interface uart_if (
    input clk,
    input rst
);
    // 신호 선언
    logic tx_start, tx, tx_busy, tx_done;
    logic [7:0] tx_data;
    logic rx, rx_done;
    logic [7:0] rx_data;

    // --- [RX Driver용] : uart_rx를 출력으로 제어 ---
    clocking rx_drv_cb @(posedge clk);
        default input #1 output #0;
        output rx;
        input rx_done;
    endclocking

    // --- [TX Driver용] : tx_start, tx_data를 출력으로 제어 ---
    clocking tx_drv_cb @(posedge clk);
        default input #1 output #0;
        output tx_start;
        output tx_data;
        input tx_busy;
        input tx_done;
    endclocking

    // --- [Monitor용] : 모든 신호를 입력으로 관찰 ---
    clocking mon_cb @(posedge clk);
        default input #1;
        input tx_start, tx_data, uart_tx, tx_busy, tx_done;
        input uart_rx, rx_data, rx_done;
    endclocking

endinterface
