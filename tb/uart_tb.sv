`include "uvm_macros.svh"
import uvm_pkg::*;
import uart_pkg::*;

`include "uart_if.sv"

module uart_tb ();

    logic clk;
    logic rstn;

    uart_if u_if (
        .clk (clk),
        .rstn(rstn)
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

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rstn = 0;
        repeat (5) @(posedge clk);
        rstn = 1;
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
















