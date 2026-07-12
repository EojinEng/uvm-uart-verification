`ifndef UART_RX_AGENT_SV
`define UART_RX_AGENT_SV

class uart_rx_agent extends uvm_agent;
    `uvm_component_utils(uart_rx_agent)

    uart_rx_monitor rx_mon;

    uvm_analysis_port #(uart_rx_sequence_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        rx_mon    = uart_rx_monitor::type_id::create("rx_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        rx_mon.ap.connect(this.ap);
    endfunction

    virtual task run_phase(uvm_phase phase);

    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
