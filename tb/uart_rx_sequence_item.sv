`ifndef UART_RX_SEQUENCE_ITEM_SV
`define UART_RX_SEQUENCE_ITEM_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_rx_sequence_item extends uvm_sequence_item;

    function new(string name = "uart_rx_sequence_item");
        super.new(name);
    endfunction  //new()

    logic [7:0] rx_data;
    logic       rx;
    logic       rx_done;

    `uvm_object_utils_begin(uart_rx_sequence_item)
        `uvm_field_int(rx_data, UVM_ALL_ON)
        `uvm_field_int(rx, UVM_ALL_ON)
        `uvm_field_int(rx_done, UVM_ALL_ON)
    `uvm_object_utils_end

endclass  //className

`endif
