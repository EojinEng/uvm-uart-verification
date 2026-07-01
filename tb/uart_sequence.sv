`ifndef UART_SEQUENCE_SV
`define UART_SEQUENCE_SV

class uart_base_sequence extends uvm_sequence #(uart_sequence_item);
    `uvm_object_utils(uart_base_sequence)

    function new(string name = "uart_base_sequence");
        super.new(name);
    endfunction  //new()

    task do_tx(int hold = 1, int idle = 1, bit [7:0] data, bit flag_hold = 0,
               bit flag_idle = 0, bit flag_data = 0);
        uart_sequence_item item;
        item = uart_sequence_item::type_id::create("item");
        start_item(item);
        if (!item.randomize() with {
                if (!flag_hold) hold_cycles == hold;
                if (!flag_idle) idle_cycles == idle;
                if (!flag_data) tx_data == data;
            }) begin
            `uvm_fatal(
                get_type_name(),
                $sformatf(
                    "Randomize Fail! (hold_cycle:%0d,idle_cycle:%0d,data:%02h)",
                    item.hold_cycles, item.idle_cycles, item.tx_data))
        end
        finish_item(item);
        get_response(item);
        `uvm_info(
            get_type_name(),
            $sformatf(
                "do_tx() tx 전송 완료: hold_cycle=%0d, idle_cycle=%0d, tx_data=0x%02h",
                item.hold_cycles, item.idle_cycles, item.tx_data), UVM_MEDIUM)
    endtask

    task do_rx(int hold = 1, int idle = 1, bit [7:0] data, bit flag_hold = 0,
               bit flag_idle = 0, bit flag_data = 0);
        uart_sequence_item item;
        item = uart_sequence_item::type_id::create("item");
        start_item(item);
        if (!item.randomize() with {
                if (!flag_hold) hold_cycles == hold;
                if (!flag_idle) idle_cycles == idle;
                if (!flag_data) rx_data == data;
            }) begin
            `uvm_fatal(
                get_type_name(),
                $sformatf(
                    "Randomize Fail! (hold_cycle:%0d,idle_cycle:%0d,data:%02h)",
                    item.hold_cycles, item.idle_cycles, item.rx_data))
        end
        finish_item(item);
        get_response(item);
        `uvm_info(
            get_type_name(),
            $sformatf(
                "do_rx() rx 전송 완료: hold_cycle=%0d, idle_cycle=%0d, rx_data=0x%02h",
                item.hold_cycles, item.idle_cycles, item.rx_data), UVM_MEDIUM)
    endtask

    virtual task body();
    endtask  //body
endclass  //component

class uart_tx_seq extends uart_base_sequence;
    `uvm_object_utils(uart_tx_seq)

    int num_loop = 10;

    function new(string name = "uart_tx_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        `uvm_info(get_type_name(), "TX base sequence start", UVM_LOW)
        for (int i = 0; i < num_loop; i++) begin
            do_tx(.hold(1), .idle(1), .data($urandom()));
        end
    endtask  //body
endclass  //uart_tx_seq

class uart_rx_seq extends uart_base_sequence;
    `uvm_object_utils(uart_rx_seq)

    int num_loop = 10;

    function new(string name = "uart_rx_seq");
        super.new(name);
    endfunction  //new()

    virtual task body();
        `uvm_info(get_type_name(), "RX base sequence start", UVM_LOW)
        for (int i = 0; i < num_loop; i++) begin
            do_rx(.hold(1), .idle(1), .data($urandom()));
        end
    endtask  //body
endclass  //uart_rx_seq

`endif
