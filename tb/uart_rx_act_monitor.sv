`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_ACT_MONITOR_SV
`define UART_RX_ACT_MONITOR_SV

class uart_rx_act_monitor extends uvm_monitor;
    `uvm_component_utils(uart_rx_act_monitor)

    function new(string name = "uart_rx_act_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uvm_analysis_port #(uart_rx_sequence_item) ap_act;
    virtual uart_if u_if;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_act = new("ap_act", this);

        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if)) begin
            `uvm_fatal(get_type_name(),
                       "FATAL! uart_if config error from rx_act_mon")
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            collect_act();
        end
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

    task collect_act();
        uart_rx_sequence_item act_item;
        act_item = uart_rx_sequence_item::type_id::create("act_item");
        @(posedge u_if.mon_cb.rx_done);
        act_item.rx_data = u_if.mon_cb.rx_data;
        ap_act.write(act_item);
        wait (u_if.mon_cb.rx_done === 1'b0);
    endtask

endclass  //component

`endif
