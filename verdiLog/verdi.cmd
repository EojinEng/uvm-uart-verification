simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_VERBOSITY=UVM_MEDIUM +ntb_random_seed=1234 +UVM_TESTNAME=uart_tx_test -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-covdir" "coverage.vdb" "-dbdir" "simv.daidir"
debLoadSimResult /home/hedu11/eojin/uart_uvm/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiSetActWin -win $_nWave2
verdiInvokeApp -vdCov
debExit
