`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_SCOREBOARD_SV
`define UART_RX_SCOREBOARD_SV

`uvm_analysis_imp_decl(_exp)
`uvm_analysis_imp_decl(_act)

class uart_rx_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_rx_scoreboard)

    function new(string name = "uart_rx_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uvm_analysis_imp_exp #(uart_rx_sequence_item, uart_rx_scoreboard) ap_imp_exp;
    uvm_analysis_imp_act #(uart_rx_sequence_item, uart_rx_scoreboard) ap_imp_act;

    uart_rx_sequence_item exp_item_buffer = null;
    int pass_cnt = 0;
    int fail_cnt = 0;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp_exp = new("ap_imp_exp", this);
        ap_imp_act = new("ap_imp_act", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("UART_RX_SCB", $sformatf(
                  "\n================================\nUART RX Scoreboard Report\n TOTAL: %0d\n PASS : %0d\n FAIL : %0d\n================================",
                  pass_cnt + fail_cnt,
                  pass_cnt,
                  fail_cnt
                  ), UVM_NONE)
    endfunction

    function void write_exp(uart_rx_sequence_item item);
        exp_item_buffer = item;
    endfunction

    function void write_act(uart_rx_sequence_item item);
        if (exp_item_buffer != null) begin
            if (exp_item_buffer.rx_data == item.rx_data) begin
                pass_cnt++;
                `uvm_info("PASS UART RX", $sformatf(
                                              "PASS! RX_exp=%0h, RX_act=%0h",
                                              exp_item_buffer.rx_data,
                                              item.rx_data), UVM_LOW)
            end else begin
                fail_cnt++;
                `uvm_info("FAIL UART RX", $sformatf(
                          "FAIL! RX_exp=%0h, RX_act=%0h",
                          exp_item_buffer.rx_data,
                          item.rx_data
                          ), UVM_LOW)
            end
            exp_item_buffer = null;
        end else begin
            fail_cnt++;
            `uvm_error(get_type_name(),
                       "FAIL! 예상값(Expected) 없이 실제값(Actual)만 들어왔습니다.")
        end
    endfunction

endclass  //component

`endif
