import uvm_pkg::*;
`include "uvm_macros.svh"
`include "uart_interface.sv"

module uart_tx_tb ();

    logic clk;
    logic reset;
    logic w_tick;

    uart_if u_if (
        .clk  (clk),
        .reset(reset)
    );

    baud_tick #(
        .BAUD_RATE(9600)
    ) u_baud_tick (
        .clk  (clk),
        .reset(reset),
        .tick (w_tick)
    );

    uart_tx dut (
        .clk     (clk),
        .reset   (reset),
        .tick    (w_tick),
        .tx_start(u_if.tx_start),
        .tx_data (u_if.tx_data),
        .tx      (u_if.tx),
        .tx_busy (u_if.tx_busy),
        .tx_done (u_if.tx_done)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        repeat (5) @(posedge clk);
        reset = 0;
    end

    initial begin
        uvm_config_db#(virtual uart_if)::set(null, "*", "u_if", u_if);
        run_test("uart_tx_test");
    end

    initial begin
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, uart_tx_tb, "+all");
    end

endmodule
