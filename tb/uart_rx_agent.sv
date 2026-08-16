`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_AGENT_SV
`define UART_RX_AGENT_SV

class uart_rx_agent extends uvm_agent;
    `uvm_component_utils(uart_rx_agent)

    function new(string name = "uart_rx_agent", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uart_rx_sequencer                          rx_spr;
    uart_rx_driver                             rx_drv;
    uart_rx_exp_monitor                        rx_exp_mon;
    uart_rx_act_monitor                        rx_act_mon;

    uvm_analysis_port #(uart_rx_sequence_item) ap_exp;
    uvm_analysis_port #(uart_rx_sequence_item) ap_act;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_exp = new("ap_exp", this);
        ap_act = new("ap_act", this);

        rx_exp_mon = uart_rx_exp_monitor::type_id::create("rx_exp_mon", this);
        rx_act_mon = uart_rx_act_monitor::type_id::create("rx_act_mon", this);

        if (get_is_active() == UVM_ACTIVE) begin
            rx_spr = uart_rx_sequencer::type_id::create("rx_spr", this);
            rx_drv = uart_rx_driver::type_id::create("rx_drv", this);
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        rx_exp_mon.ap_exp.connect(ap_exp);
        rx_act_mon.ap_act.connect(ap_act);

        if (get_is_active() == UVM_ACTIVE) begin
            rx_drv.seq_item_port.connect(rx_spr.seq_item_export);
        end

    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
