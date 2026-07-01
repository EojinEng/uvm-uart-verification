module uart_top #(
    parameter BAUD_RATE = 9600
) (
    input  logic       clk,
    input  logic       reset,
    //tx port
    input  logic       tx_start,
    input  logic [7:0] tx_data,
    output logic       tx,
    output logic       tx_busy,
    output logic       tx_done,
    //rx port
    input  logic       rx,
    output logic [7:0] rx_data,
    output logic       rx_done
);

    logic tick;
    logic rx_sync;

    baud_tick #(
        .BAUD_RATE(BAUD_RATE)
    ) u_brg (
        .clk  (clk),
        .reset(reset),
        .tick (tick)
    );

    uart_tx u_uart_tx (
        .clk     (clk),
        .reset   (reset),
        .tick    (tick),
        .tx_start(tx_start),
        .tx_data (tx_data),
        .tx      (tx),
        .tx_busy (tx_busy),
        .tx_done (tx_done)
    );

    sync_2ff u_sync_2ff (
        .clk     (clk),
        .reset   (reset),
        .async_in(rx),
        .sync_out(rx_sync)
    );

    uart_rx u_uart_rx (
        .clk    (clk),
        .reset  (reset),
        .tick   (tick),
        .rx     (rx_sync),
        .rx_data(rx_data),
        .rx_done(rx_done)
    );
endmodule

