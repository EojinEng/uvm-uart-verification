`ifndef UART_TX_MONITOR_SV
`define UART_TX_MONITOR_SV

class uart_tx_monitor extends uvm_monitor;
    `uvm_component_utils(uart_tx_monitor)

    virtual uart_if u_if;
    uvm_analysis_port #(uart_sequence_item) ap;
    uvm_analysis_port #(uart_sequence_item) ap_drv_mon;

    localparam CLKS_PER_BIT = 10416;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        ap_drv_mon = new("ap_drv_mon", this);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if))
            `uvm_fatal(get_type_name(),
                       "monitor에서 uvm_config_db 에러 발생.")
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "UART TX MONITORING START ... ", UVM_MEDIUM)
        fork
            forever begin
                collect_transaction();
            end
            forever begin
                tx_drv_monitor();
            end
        join
    endtask  //run_phase

    task collect_transaction();
        uart_sequence_item mon_tx_item;
        mon_tx_item = uart_sequence_item::type_id::create("mon_tx_item");
        // 1. START : uart_tx = 1->0으로 될 때
        wait (u_if.tx_mon_cb.tx === 0);

        repeat (CLKS_PER_BIT + (CLKS_PER_BIT / 2)) @(u_if.tx_mon_cb);

        for (int i = 0; i < 8; i++) begin
            mon_tx_item.tx_data[i] = u_if.tx_mon_cb.tx;
            `uvm_info(get_type_name(), $sformatf(
                      "Sampling Bit[%0d] = %b", i, mon_tx_item.tx_data[i]),
                      UVM_HIGH)
            repeat (CLKS_PER_BIT) @(u_if.tx_mon_cb);
        end
        @(posedge u_if.tx_mon_cb.tx_done);
        ap.write(mon_tx_item);
        `uvm_info(get_type_name(), $sformatf("mon tx: %s",
                                             mon_tx_item.convert2string()),
                  UVM_MEDIUM)
        @(u_if.tx_mon_cb);
    endtask  //collect_transaction

    task tx_drv_monitor();
        uart_sequence_item tx_drv_mon;
        tx_drv_mon = uart_sequence_item::type_id::create("tx_drv_mon");
        wait (u_if.tx_mon_cb.tx === 0);
        @(u_if.tx_mon_cb);
        tx_drv_mon.tx_data = u_if.tx_mon_cb.tx_data;
        ap_drv_mon.write(tx_drv_mon);
        @(u_if.tx_mon_cb);
        @(posedge u_if.tx_mon_cb.tx_done);
    endtask  //tx_drv_monitor

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
