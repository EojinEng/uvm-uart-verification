`ifndef UART_IF_SV
`define UART_IF_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

interface uart_if (
    input clk,
    input reset
);
    // 신호 선언
    logic [7:0] tx_data;
    logic [7:0] rx_data;
    logic tx_start, tx, tx_busy, tx_done;
    logic rx, rx_done;

    // TX Driver : tx_start, tx_data를 출력으로 제어
    clocking tx_drv_cb @(posedge clk);
        default input #1 output #0;
        output tx_start;
        output tx_data;
        input tx_busy;
        input tx_done;
    endclocking

    // RX Driver : uart_rx를 출력으로 제어
    clocking rx_drv_cb @(posedge clk);
        default input #1 output #0;
        output rx;
        input rx_done;
    endclocking

    // Monitor : 모든 신호를 입력으로 관찰
    clocking mon_cb @(posedge clk);
        default input #1;
        input tx_start, tx_data, tx, tx_busy, tx_done;
        input rx, rx_data, rx_done;
    endclocking

endinterface

`endif
