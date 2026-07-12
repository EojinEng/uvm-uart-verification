`ifndef UART_ENVIRONMENT_SV
`define UART_ENVIRONMENT_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)

    uart_tx_agent   agt_tx;
    uart_rx_agent   agt_rx;
    uart_scoreboard scb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt_tx = uart_tx_agent::type_id::create("agt_tx", this);
        agt_rx = uart_rx_agent::type_id::create("agt_rx", this);
        scb    = uart_scoreboard::type_id::create("scb", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // TX Agent(Monitor) -> Scoreboard (Expected Data)
        agt_tx.ap_tx_exp.connect(scb.ap_imp_tx_exp);
        // TX Agent(Monitor) -> Scoreboard (Actual TX Data)
        agt_tx.ap_tx_act.connect(scb.ap_imp_tx_act);
        // RX Agent(Monitor) -> Scoreboard (Actual Data)
        agt_rx.ap.connect(scb.ap_imp_rx_act);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
