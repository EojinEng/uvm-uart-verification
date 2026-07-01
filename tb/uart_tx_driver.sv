`ifndef DRIVER_SV
`define DRIVER_SV

class uart_tx_driver extends uvm_driver #(uart_sequence_item);
    `uvm_component_utils(uart_tx_driver)
    virtual uart_if u_if;

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
        uart_tx_init();
        wait (u_if.rst == 0);
        `uvm_info(get_type_name(),
                  "리셋 해제 확인. 트랜젝션 대기 중...",
                  UVM_MEDIUM)

        forever begin
            uart_sequence_item item;
            seq_item_port.get_next_item(item);
            drive_tx(item);
            seq_item_port.item_done(item);
        end
    endtask  //run_phase

    task uart_tx_init();
        u_if.tx_drv_cb.tx_start <= '0;
        u_if.tx_drv_cb.tx_data  <= '0;
    endtask  //uart_bus_init

    task drive_tx(uart_sequence_item item);
        u_if.tx_drv_cb.tx_data <= item.tx_data;
        @(u_if.tx_drv_cb);
        // 1. Start Bit
        u_if.tx_drv_cb.tx_start <= 1'b1;
        // 2. 아이템이 정한 hold_cycles만큼 대기 (예: 1클락)
        repeat (item.hold_cycles) @(u_if.tx_drv_cb);
        u_if.tx_drv_cb.tx_start <= 1'b0;

        wait (u_if.tx_drv_cb.tx_done == 1);
        @(u_if.tx_drv_cb);

        repeat (item.idle_cycles) @(u_if.tx_drv_cb);
    endtask
endclass  //component

`endif
