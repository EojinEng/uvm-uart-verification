`ifndef UART_SCOREBOARD_SV
`define UART_SCOREBOARD_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

`uvm_analysis_imp_decl(_tx_exp)
`uvm_analysis_imp_decl(_tx_act)
`uvm_analysis_imp_decl(_rx_act)

class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard)

    //expected tx
    uvm_analysis_imp_tx_exp#(uart_tx_sequence_item, uart_scoreboard) ap_imp_tx_exp;
    //actual tx
    uvm_analysis_imp_tx_act #(uart_tx_sequence_item, uart_scoreboard) ap_imp_tx_act;
    //actual rx
    uvm_analysis_imp_rx_act #(uart_rx_sequence_item, uart_scoreboard) ap_imp_rx_act;

    int pass_cnt;
    int fail_cnt;

    uart_tx_sequence_item queue_tx_exp[$];
    uart_tx_sequence_item queue_tx_act[$];
    uart_rx_sequence_item queue_rx_act[$];

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp_tx_exp = new("ap_imp_tx_exp", this);
        ap_imp_tx_act = new("ap_imp_tx_act", this);
        ap_imp_rx_act = new("ap_imp_rx_act", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            uart_tx_sequence_item tx_exp_item;
            uart_tx_sequence_item tx_item;
            uart_rx_sequence_item rx_item;

            wait ( queue_tx_exp.size() > 0 && queue_tx_act.size() > 0 && queue_rx_act.size() > 0 );
            tx_exp_item = queue_tx_exp.pop_front();
            tx_item     = queue_tx_act.pop_front();
            rx_item     = queue_rx_act.pop_front();

            if ((tx_exp_item.tx_data == tx_item.tx_data) && (tx_item.tx_data == rx_item.rx_data)) begin
                pass_cnt++;
                `uvm_info("UART_SB",
                          $sformatf("PASS! TX_exp = %0h, TX = %0h, RX = %0h",
                                    tx_exp_item.tx_data, tx_item.tx_data,
                                    rx_item.rx_data), UVM_LOW)
            end else begin
                fail_cnt++;
                `uvm_error("FAIL UART", $sformatf(
                           "TX->RX 데이터 불일치! TX_exp = %0h, TX: %0h, RX: %0h",
                           tx_exp_item.tx_data,
                           tx_item.tx_data,
                           rx_item.rx_data
                           ))
            end
        end
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("UART_SB", $sformatf(
                  "====================\nUART Scoreboard Report\nPASS : %0d\nFAIL : %0d\nTOTAL: %0d\n====================",
                  pass_cnt,
                  fail_cnt,
                  pass_cnt + fail_cnt
                  ), UVM_NONE)
    endfunction

    function void write_tx_exp(uart_tx_sequence_item tx_item);
        queue_tx_exp.push_back(tx_item);
    endfunction

    function void write_tx_act(uart_tx_sequence_item tx_item);
        queue_tx_act.push_back(tx_item);
    endfunction

    function void write_rx_act(uart_rx_sequence_item rx_item);
        queue_rx_act.push_back(rx_item);
    endfunction

endclass  //component

`endif
