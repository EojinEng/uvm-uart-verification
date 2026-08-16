`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_SEQUENCER_SV
`define UART_RX_SEQUENCER_SV

class uart_rx_sequencer extends uvm_sequencer #(uart_rx_sequence_item);
    `uvm_component_utils(uart_rx_sequencer)

    function new(string name="uart_rx_sequencer", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual task run_phase(uvm_phase phase);

    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
