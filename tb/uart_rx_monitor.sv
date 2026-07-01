`ifndef UART_RX_MONITOR_SV
`define UART_RX_MONITOR_SV

class uart_rx_monitor extends uvm_monitor;
    `uvm_component_utils(uart_rx_monitor)

    virtual uart_if u_if;
    uvm_analysis_port #(uart_sequence_item) ap;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if))
            `uvm_fatal(get_type_name(),
                       "monitor에서 uvm_config_db 에러 발생.")
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "UART RX MONITORING START ... ", UVM_MEDIUM)
        forever begin
            collect_transaction();
        end
    endtask  //run_phase

    task collect_transaction();
        uart_sequence_item mon_rx_item;
        @(posedge u_if.rx_mon_cb.rx_done);
        mon_rx_item = uart_sequence_item::type_id::create("mon_rx_item");
        mon_rx_item.rx_data = u_if.rx_mon_cb.rx_data;
        `uvm_info(get_type_name(), $sformatf("mon rx: %s",
                                             mon_rx_item.convert2string()),
                  UVM_MEDIUM)
        ap.write(mon_rx_item);
        @(u_if.rx_mon_cb);
    endtask  //collect_transaction

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
