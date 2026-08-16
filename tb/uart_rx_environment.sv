`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_ENVIRONMENT_SV
`define UART_RX_ENVIRONMENT_SV

class uart_rx_environment extends uvm_env;
    `uvm_component_utils(uart_rx_environment)

    function new(string name="uart_rx_environment", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uart_rx_agent rx_agt;
    uart_rx_scoreboard rx_scb;
    uart_rx_coverage rx_cov;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rx_agt = uart_rx_agent::type_id::create("rx_agt", this);
        rx_scb = uart_rx_scoreboard::type_id::create("rx_scb", this);
        rx_cov = uart_rx_coverage::type_id::create("rx_cov", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // TX Agent(exp monitor) -> scoreboard (exp data)
        rx_agt.ap_exp.connect(rx_scb.ap_imp_exp);
        // TX Agent(act monitor) -> scoreboard (act data)
        rx_agt.ap_act.connect(rx_scb.ap_imp_act);
        // TX Agent(exp monitor) -> coverage (exp data)
        rx_agt.ap_exp.connect(rx_cov.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
