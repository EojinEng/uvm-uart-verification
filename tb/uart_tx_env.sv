import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_TX_ENVIRONMENT_SV
`define UART_TX_ENVIRONMENT_SV

class uart_tx_env extends uvm_env;
    `uvm_component_utils(uart_tx_env)

    function new(string name = "uart_tx_env", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uart_tx_agent agt_tx;
    uart_tx_scoreboard scb_tx;
    uart_tx_coverage cov_tx;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt_tx = uart_tx_agent::type_id::create("agt_tx", this);
        scb_tx = uart_tx_scoreboard::type_id::create("scb_tx", this);
        cov_tx = uart_tx_coverage::type_id::create("cov_tx", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // TX Agent(Monitor) -> Scoreboard (Expected Data)
        agt_tx.ap_tx_in_exp.connect(scb_tx.ap_imp_tx_exp);
        // TX Agent(Monitor) -> Scoreboard (Actual TX Data)
        agt_tx.ap_tx_out_act.connect(scb_tx.ap_imp_tx_act);
        // TX Agent(Monitor) -> Coverage (Input Data Sampling)
        agt_tx.ap_tx_in_exp.connect(cov_tx.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
