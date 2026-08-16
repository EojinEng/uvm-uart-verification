import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_TX_COVERAGE_SV
`define UART_TX_COVERAGE_SV

class uart_tx_coverage extends uvm_subscriber #(uart_tx_sequence_item);
    `uvm_component_utils(uart_tx_coverage)

    function new(string name="uart_tx_coverage", uvm_component parent);
        super.new(name, parent);
        tx_cg = new();
    endfunction  //new()

    uart_tx_sequence_item cov_item;

    covergroup tx_cg;
        cp_tx_data: coverpoint cov_item.tx_data;
    endgroup

    virtual function void write(uart_tx_sequence_item item);
        cov_item = item;
        tx_cg.sample();
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
