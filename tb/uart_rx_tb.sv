import uvm_pkg::*;
`include "uvm_macros.svh"
`include "uart_interface.sv"

module uart_rx_tb ();

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

    uart_rx dut (
        .clk    (clk),
        .reset  (reset),
        .tick   (w_tick),
        .rx     (u_if.rx),
        .rx_data(u_if.rx_data),
        .rx_done(u_if.rx_done)
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
        run_test("uart_rx_test");
    end

    initial begin
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, uart_rx_tb, "+all");
    end

endmodule
