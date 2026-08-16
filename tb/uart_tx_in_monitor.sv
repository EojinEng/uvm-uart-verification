import uvm_pkg::*;
`include "uvm_macros.svh"
`ifndef UART_TX_IN_MONITOR_SV
`define UART_TX_IN_MONITOR_SV

class uart_tx_in_monitor extends uvm_monitor;

    `uvm_component_utils(uart_tx_in_monitor)

    function new(string name = "uart_tx_in_monitor", uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual uart_if u_if;
    uvm_analysis_port #(uart_tx_sequence_item) ap_in_mon;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap_in_mon = new("ap_in_mon", this);

        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if))
            `uvm_fatal(get_type_name(),
                       "monitor에서 uvm_config_db 에러 발생.")
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "UART TX MONITORING START ... ", UVM_MEDIUM)
        forever begin
            collect_transaction();
        end
    endtask  //run_phase

    task collect_transaction();
        uart_tx_sequence_item mon_tx_in_item;
        mon_tx_in_item =
            uart_tx_sequence_item::type_id::create("mon_tx_in_item");

        @(posedge u_if.mon_cb.tx_start);
        mon_tx_in_item.tx_data = u_if.mon_cb.tx_data;
        ap_in_mon.write(mon_tx_in_item);
        `uvm_info(get_type_name(), $sformatf("mon input tx_data = %0h",
                                             mon_tx_in_item.tx_data), UVM_HIGH)
    endtask  //collect_transaction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
