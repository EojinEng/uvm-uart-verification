`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_SEQUENCE_SV
`define UART_RX_SEQUENCE_SV

class uart_rx_sequence extends uvm_sequence #(uart_rx_sequence_item);
    `uvm_object_utils(uart_rx_sequence)

    function new(string name="uart_rx_sequence");
        super.new(name);
    endfunction  //new()

    virtual task body();
    endtask

endclass  //object

class random_rx_seq extends uart_rx_sequence;
    `uvm_object_utils(random_rx_seq)

    function new(string name="random_rx_seq");
        super.new(name);
    endfunction //new()

    int repeat_num = 500;

    virtual task body();
        uart_rx_sequence_item item;
        repeat(repeat_num) begin
            item = uart_rx_sequence_item::type_id::create("item");

            start_item(item);
            if(!item.randomize()) begin
                `uvm_fatal(get_type_name(), "FATAL! rx randomize failed")
            end
            finish_item(item);
        end
    endtask

endclass //random_rx_seq

`endif
