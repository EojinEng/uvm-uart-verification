`ifndef UART_TEST_SV
`define UART_TEST_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_test extends uvm_test;
    `uvm_component_utils(uart_test)

    uart_env env;

    function new(string name = "uart_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uvm_config_db#(int)::set(this, "*", "clk_freq", 100_000_000);
        uvm_config_db#(int)::set(this, "*", "baud_rate", 9600);
        env = uart_env::type_id::create("env", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "==== uvm 계층 구조==== ", UVM_MEDIUM)
        uvm_top.print_topology();
    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_random_seq seq;

        phase.raise_objection(this);

        seq = uart_random_seq::type_id::create("seq");

        seq.start(env.agt_tx.tx_sqr);

        phase.drop_objection(this);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
