import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef UART_TX_SCOREBOARD_SV
`define UART_TX_SCOREBOARD_SV

`uvm_analysis_imp_decl(_tx_in_exp)
`uvm_analysis_imp_decl(_tx_out_act)

class uart_tx_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_tx_scoreboard)

    function new(string name = "uart_tx_scoreboard", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    //expected tx
    uvm_analysis_imp_tx_in_exp#(uart_tx_sequence_item, uart_tx_scoreboard) ap_imp_tx_exp;
    //actual tx
    uvm_analysis_imp_tx_out_act #(uart_tx_sequence_item, uart_tx_scoreboard) ap_imp_tx_act;

    int pass_cnt;
    int fail_cnt;

    uart_tx_sequence_item queue_tx_in_exp[$];
    uart_tx_sequence_item queue_tx_out_act[$];

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp_tx_exp = new("ap_imp_tx_exp", this);
        ap_imp_tx_act = new("ap_imp_tx_act", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("UART_SB", $sformatf(
                  "====================\nUART Scoreboard Report\n TOTAL: %0d\n PASS : %0d\n FAIL : %0d\n====================",
                  pass_cnt + fail_cnt,
                  pass_cnt,
                  fail_cnt
                  ), UVM_NONE)
    endfunction

    function void write_tx_in_exp(uart_tx_sequence_item tx_item);
        queue_tx_in_exp.push_back(tx_item);
    endfunction

    function void write_tx_out_act(uart_tx_sequence_item tx_item);
        uart_tx_sequence_item tx_exp_item;
        uart_tx_sequence_item tx_act_item;
        queue_tx_out_act.push_back(tx_item);

        if (queue_tx_in_exp.size() > 0) begin
            tx_exp_item = queue_tx_in_exp.pop_front();
            tx_act_item = queue_tx_out_act.pop_front();

            if ((tx_exp_item.tx_data == tx_act_item.tx_data)) begin
                pass_cnt++;
                `uvm_info("PASS UART", $sformatf(
                                           "PASS! TX_exp = %0h, TX_act = %0h",
                                           tx_exp_item.tx_data,
                                           tx_act_item.tx_data), UVM_LOW)
            end else begin
                fail_cnt++;
                `uvm_error("FAIL UART", $sformatf(
                           "TX expected <-> Tx actual 데이터 불일치! TX_exp = %0h, TX_act: %0h",
                           tx_exp_item.tx_data,
                           tx_act_item.tx_data
                           ))
            end
        end else begin
            fail_cnt ++;
            `uvm_error(get_type_name()," FAIL UART, NOT EXPECTED TX ")
        end
    endfunction

endclass  //component

`endif
