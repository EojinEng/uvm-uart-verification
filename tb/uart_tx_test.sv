import uvm_pkg::*;
`include "uvm_macros.svh"

`ifndef UART_TX_TEST_SV
`define UART_TX_TEST_SV

class uart_tx_test extends uvm_test;
    `uvm_component_utils(uart_tx_test)

    function new(string name = "uart_tx_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    uart_tx_env env_tx;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(int)::set(this, "*", "clk_freq", 100_000_000);
        uvm_config_db#(int)::set(this, "*", "baud_rate", 9600);
        env_tx = uart_tx_env::type_id::create("env_tx", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "==== uvm 계층 구조==== ", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_random_seq seq;
        seq = uart_random_seq::type_id::create("seq");

        phase.raise_objection(this);

        seq.start(env_tx.agt_tx.tx_sqr);

        phase.drop_objection(this);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
