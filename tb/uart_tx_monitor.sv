`ifndef UART_TX_MONITOR_SV
`define UART_TX_MONITOR_SV
import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_tx_monitor extends uvm_monitor;

    `uvm_component_utils(uart_tx_monitor)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual uart_if u_if;

    int clk_freq;
    int baud_rate;
    int clks_per_bit;

    uvm_analysis_port #(uart_tx_sequence_item) ap;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        ap = new("ap", this);

        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if))
            `uvm_fatal(get_type_name(),
                       "monitor에서 uvm_config_db 에러 발생.")

        if (!uvm_config_db#(int)::get(this, "", "clk_freq", clk_freq))
            `uvm_fatal(get_type_name(), "clk_freq not found")

        if (!uvm_config_db#(int)::get(this, "", "baud_rate", baud_rate))
            `uvm_fatal(get_type_name(), "baud_rate not found")

        clks_per_bit = clk_freq / baud_rate;

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
        uart_tx_sequence_item mon_tx_item;
        mon_tx_item = uart_tx_sequence_item::type_id::create("mon_tx_item");
        // START : uart_tx = 1->0으로 될 때
        wait (u_if.mon_cb.tx === 0);

        repeat (clks_per_bit + (clks_per_bit / 2)) @(u_if.mon_cb);

        for (int i = 0; i < 8; i++) begin
            mon_tx_item.tx_data[i] = u_if.mon_cb.tx;
            `uvm_info(get_type_name(), $sformatf(
                      "Sampling Bit[%0d] = %b", i, mon_tx_item.tx_data[i]),
                      UVM_HIGH)
            repeat (clks_per_bit) @(u_if.mon_cb);
        end

        @(posedge u_if.mon_cb.tx_done);
        ap.write(mon_tx_item);
        `uvm_info(get_type_name(), $sformatf("mon tx data = %0h",
                                             mon_tx_item.tx_data), UVM_HIGH)
        @(u_if.mon_cb);
    endtask  //collect_transaction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
