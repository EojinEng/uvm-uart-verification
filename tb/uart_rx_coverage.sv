import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_RX_COVERAGE_SV
`define UART_RX_COVERAGE_SV

class uart_rx_coverage extends uvm_subscriber #(uart_rx_sequence_item);
    `uvm_component_utils(uart_rx_coverage)

    function new(string name="uart_rx_coverage", uvm_component parent);
        super.new(name, parent);
        rx_cg = new();
    endfunction  //new()

    uart_rx_sequence_item cov_item;

    covergroup rx_cg;
        cp_rx_data: coverpoint cov_item.rx_data;
    endgroup

    virtual function void write(uart_rx_sequence_item item);
        cov_item = item;
        rx_cg.sample();
    endfunction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
