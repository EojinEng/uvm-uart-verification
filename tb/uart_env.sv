`ifndef UART_ENVIRONMENT_SV
`define UART_ENVIRONMENT_SV

class uart_env extends uvm_env;
    `uvm_component_utils(uart_env)

    uart_tx_agent   agt_tx;
    uart_rx_agent   agt_rx;
    uart_scoreboard scb;
    uart_coverage   cov;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agt_tx = uart_tx_agent::type_id::create("agt_tx", this);
        agt_rx = uart_rx_agent::type_id::create("agt_rx", this);
        scb    = uart_scoreboard::type_id::create("scb", this);
        cov    = uart_coverage::type_id::create("cov", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        // 1. TX Agent(Monitor) -> Scoreboard (Expected Data)
        // agt_tx에 만들어둔 ap(Analysis Port)를 스코어보드에 연결합니다.
        agt_tx.ap.connect(scb.ap_imp_tx);
        agt_tx.ap_drv_mon.connect(scb.ap_tx_drv_mon);
        // 2. RX Agent(Monitor) -> Scoreboard (Actual Data)
        // agt_rx의 ap를 스코어보드의 다른 입구에 연결합니다.
        agt_rx.ap.connect(scb.ap_imp_rx);
        // 3. 커버리지(Coverage) 연결 (선택 사항)
        agt_tx.ap.connect(cov.analysis_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

endclass  //component

`endif
