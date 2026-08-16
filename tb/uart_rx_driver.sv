import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_RX_DRIVER_SV
`define UART_RX_DRIVER_SV

class uart_rx_driver extends uvm_driver #(uart_rx_sequence_item);
    `uvm_component_utils(uart_rx_driver)

    function new(string name = "uart_rx_driver", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual uart_if u_if;
    int sys_clk = 100_000_000;
    int baudrate = 9600;

    int clks_per_bit = sys_clk / baudrate;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if)) begin
            `uvm_fatal(get_type_name(),
                       "FATAL! interface config error, from driver")
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_rx_init();
        wait (u_if.reset == 0);
        forever begin
            uart_rx_sequence_item item;
            seq_item_port.get_next_item(item);
            uart_rx_drive(item);
            seq_item_port.item_done();
        end
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

    virtual task uart_rx_init();
        u_if.rx_drv_cb.rx <= 1;
    endtask

    virtual task uart_rx_drive(uart_rx_sequence_item item);
        u_if.rx_drv_cb.rx <= 0;
        repeat (clks_per_bit) @(posedge u_if.clk);
        for (int i = 0; i < 8; i++) begin
            u_if.rx_drv_cb.rx <= item.rx_data[i];
            repeat (clks_per_bit) begin
                @(posedge u_if.clk);  // 1비트 길이만큼 값을 유지
            end
        end
        u_if.rx_drv_cb.rx <= 1;
        repeat (clks_per_bit) @(posedge u_if.clk);
    endtask

endclass  //component

`endif
