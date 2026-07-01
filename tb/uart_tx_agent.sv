`ifndef UART_TX_AGENT_SV
`define UART_TX_AGENT_SV

class uart_tx_agent extends uvm_agent;
    `uvm_component_utils(uart_tx_agent)

    uart_tx_sequencer tx_sqr;
    uart_tx_driver    drv;
    uart_tx_monitor   mon;

    uvm_analysis_port #(uart_sequence_item) ap;
    uvm_analysis_port #(uart_sequence_item) ap_drv_mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap = new("ap", this);
        ap_drv_mon = new("ap_drv_mon", this);
        drv = uart_tx_driver::type_id::create("drv", this);
        mon = uart_tx_monitor::type_id::create("mon", this);
        tx_sqr = uart_tx_sequencer::type_id::create("tx_sqr", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        // 시퀀서-드라이버 연결
        drv.seq_item_port.connect(tx_sqr.seq_item_export);
        // 3. 모니터 포트를 에이전트 포트에 연결 (중요!)
        mon.ap.connect(this.ap);
        mon.ap_drv_mon.connect(this.ap_drv_mon);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
