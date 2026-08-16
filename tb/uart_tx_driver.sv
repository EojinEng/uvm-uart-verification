import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef UART_TX_DRIVER_SV
`define UART_TX_DRIVER_SV

class uart_tx_driver extends uvm_driver #(uart_tx_sequence_item);

    //항상 UVM 등록 먼저
    `uvm_component_utils(uart_tx_driver)

    //new()함수 정의
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    //가상 인터페이스 연결
    virtual uart_if u_if;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if)) begin
            `uvm_fatal(get_type_name(),
                       "driver에서 uvm_config_db 에러 발생.");
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_tx_init();
        wait (u_if.reset == 0);
        `uvm_info(get_type_name(),
                  "리셋 해제 확인. 트랜젝션 대기 중...",
                  UVM_MEDIUM)

        forever begin
            uart_tx_sequence_item item;
            seq_item_port.get_next_item(item);
            drive_tx(item);
            seq_item_port.item_done();
        end
    endtask  //run_phase

    task uart_tx_init();
        u_if.tx_drv_cb.tx_start <= '0;
        u_if.tx_drv_cb.tx_data  <= '0;
    endtask  //uart_bus_init

    task drive_tx(uart_tx_sequence_item item);
        u_if.tx_drv_cb.tx_data <= item.tx_data;
        @(u_if.tx_drv_cb);

        //Start Bit
        u_if.tx_drv_cb.tx_start <= 1'b1;
        @(u_if.tx_drv_cb);
        u_if.tx_drv_cb.tx_start <= 1'b0;

        //Wait Done
        wait (u_if.tx_drv_cb.tx_done == 1);
        @(u_if.tx_drv_cb);

        repeat (item.idle_cycles) @(u_if.tx_drv_cb);
    endtask
endclass  //component

`endif
