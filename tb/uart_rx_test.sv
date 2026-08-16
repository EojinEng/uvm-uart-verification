`include "uvm_macros.svh"
import uvm_pkg::*;

`ifndef UART_RX_TEST_SV
`define UART_RX_TEST_SV

class uart_rx_test extends uvm_test;
    `uvm_component_utils(uart_rx_test)

    function new(string name = "uart_rx_test", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    uart_rx_environment rx_env;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        rx_env = uart_rx_environment::type_id::create("rx_env", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        random_rx_seq seq;
        seq = random_rx_seq::type_id::create("seq");
        phase.raise_objection(this);
        seq.start(rx_env.rx_agt.rx_spr);
        phase.drop_objection(this);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
