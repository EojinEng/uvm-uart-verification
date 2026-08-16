`ifndef UART_PKG_SV
`define UART_PKG_SV

package uart_pkg;
    // UVM 필수 라이브러리 탑재
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    // 1. 데이터
    `include "uart_tx_sequence_item.sv"
    `include "uart_rx_sequence_item.sv"

    // 2. agent 하위
    `include "uart_tx_monitor.sv"
    `include "uart_rx_monitor.sv"
    `include "uart_tx_driver.sv"
    `include "uart_tx_sequencer.sv"

    // 3. agent
    `include "uart_tx_agent.sv"
    `include "uart_rx_agent.sv"

    // 4. 환경 (Env)

endpackage

`endif
