import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef UART_TX_AGENT_SV
`define UART_TX_AGENT_SV

class uart_tx_agent extends uvm_agent;
    `uvm_component_utils(uart_tx_agent)

    function new(string name = "uart_tx_agent", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uart_tx_sequencer tx_sqr;
    uart_tx_driver    tx_drv;
    uart_tx_in_monitor   tx_in_mon;
    uart_tx_out_monitor   tx_out_mon;

    uvm_analysis_port #(uart_tx_sequence_item) ap_tx_in_exp;
    uvm_analysis_port #(uart_tx_sequence_item) ap_tx_out_act;


    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        tx_in_mon = uart_tx_in_monitor::type_id::create("tx_in_mon", this);
        tx_out_mon = uart_tx_out_monitor::type_id::create("tx_out_mon", this);
        ap_tx_in_exp = new("ap_tx_in_exp", this);
        ap_tx_out_act = new("ap_tx_out_act", this);

        // 시퀀서와 드라이버는 ACTIVE 모드일 때만 생성
        if (get_is_active() == UVM_ACTIVE) begin
            tx_sqr = uart_tx_sequencer::type_id::create("tx_sqr", this);
            tx_drv = uart_tx_driver::type_id::create("tx_drv", this);
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        // ACTIVE 모드일 때만 시퀀서 <-> 드라이버 포트 연결
        if (get_is_active() == UVM_ACTIVE) begin
            tx_drv.seq_item_port.connect(tx_sqr.seq_item_export);
        end

        // tx in monitor ap port <-> tx agent ap_tx_exp port
        tx_in_mon.ap_in_mon.connect(ap_tx_in_exp);
        // tx monitor ap port <-> tx agent ap_tx_act port
        tx_out_mon.ap_out_mon.connect(ap_tx_out_act);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
