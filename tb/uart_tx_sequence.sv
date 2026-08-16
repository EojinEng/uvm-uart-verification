import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef UART_TX_SEQUENCE_SV
`define UART_TX_SEQUENCE_SV

class uart_base_sequence extends uvm_sequence #(uart_tx_sequence_item);

    `uvm_object_utils(uart_base_sequence)

    // new()가 하는 일:
    // 객체 이름 설정
    // parent class 초기화 (super.new)
    // 기본값 세팅
    // 내부 변수 초기 상태 설정
    function new(string name = "uart_base_sequence");
        super.new(name);
    endfunction

    virtual task body();
    endtask

endclass

class uart_random_seq extends uart_base_sequence;

    `uvm_object_utils(uart_random_seq)

    function new(string name = "uart_random_seq");
        super.new(name);
    endfunction

    int repeat_num = 500;

    virtual task body();

        uart_tx_sequence_item item;

        repeat (repeat_num) begin

            item = uart_tx_sequence_item::type_id::create("item");

            start_item(item);
            if (!item.randomize()) begin
                `uvm_fatal(get_type_name(), "Randomization Failed")
            end
            finish_item(item);
        end
    endtask
endclass

class uart_pattern_seq extends uart_base_sequence;

    `uvm_object_utils(uart_pattern_seq)

    function new(string name = "uart_pattern_seq");
        super.new(name);
    endfunction

    bit [7:0] pattern[$] = '{8'h00, 8'hFF, 8'hAA, 8'h55, 8'hA5, 8'h5A};

    virtual task body();

        uart_tx_sequence_item item;

        foreach (pattern[i]) begin

            item = uart_tx_sequence_item::type_id::create("item");

            start_item(item);
            if (!item.randomize() with {tx_data == pattern[i];}) begin
                `uvm_fatal(get_type_name(), "Randomization Failed")
            end
            finish_item(item);
        end
    endtask
endclass

`endif
