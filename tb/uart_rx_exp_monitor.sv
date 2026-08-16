`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_EXP_MONITOR_SV
`define UART_RX_EXP_MONITOR_SV

class uart_rx_exp_monitor extends uvm_monitor;
    `uvm_component_utils(uart_rx_exp_monitor)

    function new(string name = "uart_rx_exp_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual uart_if u_if;
    uvm_analysis_port #(uart_rx_sequence_item) ap_exp;

    int sys_clk = 100_000_000;
    int baud_rate = 9600;
    int bit_pertime = sys_clk / baud_rate;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_exp = new("ap_exp", this);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if)) begin
            `uvm_fatal(get_type_name(),
                       "FATAL! config error uart_if, from exp_monitor")
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            collect_exp();
        end
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

    task collect_exp();
        uart_rx_sequence_item exp_item;
        exp_item = uart_rx_sequence_item::type_id::create("exp_item");

        wait(u_if.mon_cb.rx == 0);
        repeat(bit_pertime + (bit_pertime/2)) @(u_if.mon_cb);
        exp_item.rx_data[0] = u_if.mon_cb.rx;
        for(int i=1; i<8;i++) begin
            repeat(bit_pertime) @(u_if.mon_cb);
            exp_item.rx_data[i] = u_if.mon_cb.rx;
        end
        ap_exp.write(exp_item);
        wait(u_if.mon_cb.rx==1);
    endtask
endclass  //component

`endif
