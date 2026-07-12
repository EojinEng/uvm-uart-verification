`include "uvm_macros.svh"
`include "uart_interface.sv"
import uvm_pkg::*;

module uart_tb ();

    logic clk;
    logic reset;

    uart_if u_if (
        .clk (clk),
        .reset(reset)
    );

    uart_top #(
        .BAUD_RATE(9600)
    ) dut (
        .clk     (clk),
        .reset   (reset),
        .tx_start(u_if.tx_start),
        .tx_data (u_if.tx_data),
        .tx      (u_if.tx),
        .tx_busy (u_if.tx_busy),
        .tx_done (u_if.tx_done),
        .rx      (u_if.rx),
        .rx_data (u_if.rx_data),
        .rx_done (u_if.rx_done)
    );

    assign u_if.rx = u_if.tx;    

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        reset = 1;
        repeat (5) @(posedge clk);
        reset = 0;
    end

    initial begin
        uvm_config_db#(virtual uart_if)::set(null, "*", "u_if", u_if);
        run_test();
    end

    initial begin
        $fsdbDumpfile("novas.fsdb");
        $fsdbDumpvars(0, uart_tb, "+all");
    end

endmodule















