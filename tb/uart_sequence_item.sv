`ifndef UART_SEQUENCE_ITEM_SV
`define UART_SEQUENCE_ITEM_SV

class uart_sequence_item extends uvm_sequence_item;

    rand logic [7:0] tx_data;
    logic tx_start = 0;
    logic tx;
    logic tx_busy;
    logic tx_done;
    //
    rand logic [7:0] rx_data;
    logic rx;
    logic rx_done;
    //
    rand int hold_cycles = 1;  // 몇 클락 유지할 것인가?
    rand int idle_cycles = 1;  // 전송 완료 후 몇 클락을 쉴 것인가?

    // 현실적인 범위 설정
    constraint c_timing {
        soft hold_cycles inside
            {[1 : 5]};  // 보통 1클락이지만 3클락까지 테스트
    }

    // 연속 전송의 빈도를 높이고 싶다면 'dist'를 사용
    constraint c_idle_dist {
        soft idle_cycles dist {
            0 := 40,
            [1 : 10] := 60
        };  // 40% 확률로 연속 전송 시도
    }

    `uvm_object_utils_begin(uart_sequence_item)
        `uvm_field_int(tx_start, UVM_ALL_ON)
        `uvm_field_int(tx_data, UVM_ALL_ON)
        `uvm_field_int(tx_busy, UVM_ALL_ON)
        `uvm_field_int(tx_done, UVM_ALL_ON)
        `uvm_field_int(tx, UVM_ALL_ON)
        `uvm_field_int(rx, UVM_ALL_ON)
        `uvm_field_int(rx_data, UVM_ALL_ON)
        `uvm_field_int(rx_done, UVM_ALL_ON)
        `uvm_field_int(hold_cycles, UVM_ALL_ON)
        `uvm_field_int(idle_cycles, UVM_ALL_ON)
    `uvm_object_utils_end

    function new(string name);
        super.new(name);
    endfunction  //new()
endclass
`endif
