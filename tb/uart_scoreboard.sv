`ifndef UART_SCOREBOARD_SV
`define UART_SCOREBOARD_SV
`uvm_analysis_imp_decl(_tx)
`uvm_analysis_imp_decl(_tx_drv_mon)
`uvm_analysis_imp_decl(_rx)
`uvm_analysis_imp_decl(_rx_drv_mon)

class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(uart_scoreboard)

    uvm_analysis_imp_tx #(uart_sequence_itme, uart_scoreboard) ap_imp_tx;
    uvm_analysis_imp_tx_drv_mon #(uart_sequence_itme, uart_scoreboard) ap_tx_drv_mon;
    uvm_analysis_imp_rx #(uart_sequence_itme, uart_scoreboard) ap_imp_rx;
    uvm_analysis_imp_rx_drv_mon #(uart_sequence_itme, uart_scoreboard) ap_rx_drv_mon;

    logic [7:0] ref_tx_data, ref_rx_data;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        ap_imp_tx     = new("ap_imp_tx", this);
        ap_tx_drv_mon = new("ap_tx_drv_mon", this);
        ap_imp_rx     = new("ap_imp_rx", this);
        ap_rx_drv_mon = new("ap_rx_drv_mon", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
    endtask  //run_phase

    virtual function void report_phase(uvm_phase phase);
        super.report_phase(phase);
    endfunction

    function void write_tx(uart_sequence_item tx_item);
    endfunction

    function void write_rx(uart_sequence_item rx_item);
    endfunction

endclass  //component

`endif
