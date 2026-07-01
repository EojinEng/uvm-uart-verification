`ifndef UART_RX_DRIVER_SV
`define UART_RX_DRIVER_SV

class uart_rx_driver extends uvm_driver #(uart_sequence_item);
    `uvm_component_utils(uart_rx_driver)
    virtual uart_if u_if;

    // 1비트당 필요한 클럭 수 (예: 100MHz / 9600bps)
    localparam CLK_FREQ = 100_000_000;
    localparam BAUD_RATE = 9600;
    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;  //10416

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction  //new()

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db#(virtual uart_if)::get(this, "", "u_if", u_if)) begin
            `uvm_fatal(get_type_name(),
                       "driver에서 uvm_config_db 에러 발생.");
        end
    endfunction

    virtual function void connect_phase(uvm_phase phase);
    endfunction

    virtual task run_phase(uvm_phase phase);
        uart_rx_init();
        wait (u_if.rst == 0);
        `uvm_info(get_type_name(),
                  "리셋 해제 확인. 트랜젝션 대기 중...",
                  UVM_MEDIUM)
        forever begin
            uart_sequence_item item;
            seq_item_port.get_next_item(item);
            drive_rx(item);
            seq_item_port.item_done(item);
        end
    endtask  //run_phase

    task uart_rx_init();
        u_if.rx_drv_cb.uart_rx <= '1;
    endtask  //uart_bus_init

    task drive_rx(uart_sequence_item item);
        // Start Bit
        @(u_if.rx_drv_cb);
        u_if.rx_drv_cb.uart_rx <= 1'b0;
        //9600hz 대기하기 위함
        repeat (CLKS_PER_BIT) @(u_if.rx_drv_cb);
        // Data Bits
        for (int i = 0; i < 8; i++) begin
            u_if.rx_drv_cb.uart_rx <= item.rx_data[i];
            repeat (CLKS_PER_BIT) @(u_if.rx_drv_cb);
        end
        // Stop Bit
        u_if.rx_drv_cb.uart_rx <= 1'b1;
        repeat (CLKS_PER_BIT) @(u_if.rx_drv_cb);
    endtask

endclass  //component

`endif
