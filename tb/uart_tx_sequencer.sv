`ifndef UART_TX_SEQUENCER_SV
`define UART_TX_SEQUENCER_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_tx_sequencer extends uvm_sequencer #(uart_tx_sequence_item);

    `uvm_component_utils(uart_tx_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

endclass

`endif
