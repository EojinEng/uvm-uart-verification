import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_TX_SEQUENCE_ITEM_SV
`define UART_TX_SEQUENCE_ITEM_SV

class uart_tx_sequence_item extends uvm_sequence_item;

    function new(string name = "uart_tx_sequence_item");
        super.new(name);
    endfunction

    rand logic [7:0] tx_data;

    // 시작 신호를 몇 클락 유지할 것인가?
    rand int hold_cycles = 1;

    // 전송 완료 후 몇 클락을 쉴 것인가?
    rand int idle_cycles = 1;

    constraint tx_c {
        soft hold_cycles inside {[0 : 255]};
    }  // 8비트 범위 안전망
    constraint timing_c {soft hold_cycles inside {[1 : 5]};}

    // 연속 전송의 빈도를 높이고 싶다면 'dist'를 사용
    constraint idle_dist_c {
        soft idle_cycles dist {
            0 := 40,
            [1 : 10] := 60
        };  // 40% 확률로 연속 전송 시도
    }

    `uvm_object_utils_begin(uart_tx_sequence_item)
        `uvm_field_int(tx_data, UVM_ALL_ON)
        `uvm_field_int(hold_cycles, UVM_ALL_ON)
        `uvm_field_int(idle_cycles, UVM_ALL_ON)
    `uvm_object_utils_end

    //factory override 테스트 해보기

endclass

`endif
