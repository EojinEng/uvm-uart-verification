`ifndef UART_TX_AGENT_SV
`define UART_TX_AGENT_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_tx_agent extends uvm_agent;
    `uvm_component_utils(uart_tx_agent)

    uart_tx_sequencer tx_sqr;
    uart_tx_driver    tx_drv;
    uart_tx_monitor   tx_mon;

    uvm_analysis_port #(uart_tx_sequence_item) ap_tx_exp;
    uvm_analysis_port #(uart_tx_sequence_item) ap_tx_act;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_tx_exp = new("ap_tx_exp", this);
        ap_tx_act = new("ap_tx_act", this);
        tx_sqr = uart_tx_sequencer::type_id::create("tx_sqr", this);
        tx_drv = uart_tx_driver::type_id::create("tx_drv", this);
        tx_mon = uart_tx_monitor::type_id::create("tx_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        // 시퀀서 <-> 드라이버 연결
        tx_drv.seq_item_port.connect(tx_sqr.seq_item_export);
        // tx driver ap port <-> tx agent ap_tx_exp port
        tx_drv.ap.connect(ap_tx_exp);
        // tx monitor ap port <-> tx agent ap_tx_act port
        tx_mon.ap.connect(ap_tx_act);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
