simSetSimulator "-vcssv" -exec "simv" -args \
           "+UVM_VERBOSITY=UVM_MEDIUM +ntb_random_seed=1234 +UVM_TESTNAME=uart_test -cm line+cond+fsm+tgl+branch+assert -cm_dir coverage.vdb -cm_name sim1"
debImport "-covdir" "coverage.vdb" "-dbdir" "simv.daidir"
debLoadSimResult /home/hedu11/eojin/uart_uvm/novas.fsdb
wvCreateWindow
verdiSetActWin -win $_nWave2
verdiWindowResize -win $_Verdi_1 "311" "355" "900" "700"
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
srcHBSelect "uart_tb.dut" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.mon_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.rx_drv_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.rx_drv_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.rx_drv_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.tx_drv_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.tx_drv_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.tx_drv_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.mon_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
verdiSetActWin -win $_nWave2
wvGetSignalOpen -win $_nWave2
wvGetSignalSetScope -win $_nWave2 "/uart_tb"
wvGetSignalSetScope -win $_nWave2 "/uart_tb/u_if"
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/uart_tb/u_if/clk} \
{/uart_tb/u_if/reset} \
{/uart_tb/u_if/rx} \
{/uart_tb/u_if/rx_data\[7:0\]} \
{/uart_tb/u_if/rx_done} \
{/uart_tb/u_if/tx} \
{/uart_tb/u_if/tx_busy} \
{/uart_tb/u_if/tx_data\[7:0\]} \
{/uart_tb/u_if/tx_done} \
{/uart_tb/u_if/tx_start} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 9 10 )} 
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvAddSignal -win $_nWave2 -clear
wvAddSignal -win $_nWave2 -group {"G1" \
{/uart_tb/u_if/clk} \
{/uart_tb/u_if/reset} \
{/uart_tb/u_if/rx} \
{/uart_tb/u_if/rx_data\[7:0\]} \
{/uart_tb/u_if/rx_done} \
{/uart_tb/u_if/tx} \
{/uart_tb/u_if/tx_busy} \
{/uart_tb/u_if/tx_data\[7:0\]} \
{/uart_tb/u_if/tx_done} \
{/uart_tb/u_if/tx_start} \
}
wvAddSignal -win $_nWave2 -group {"G2" \
}
wvSelectSignal -win $_nWave2 {( "G1" 1 2 3 4 5 6 7 8 9 10 )} 
wvSetPosition -win $_nWave2 {("G1" 10)}
wvGetSignalClose -win $_nWave2
wvSelectGroup -win $_nWave2 {G2}
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 5 )} 
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 2)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 2)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 10 )} 
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 3)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSelectSignal -win $_nWave2 {( "G1" 3 )} 
wvSetPosition -win $_nWave2 {("G1" 3)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G1" 10)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSetPosition -win $_nWave2 {("G1" 4)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 4)}
wvSetPosition -win $_nWave2 {("G1" 5)}
wvSelectSignal -win $_nWave2 {( "G1" 9 )} 
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSetPosition -win $_nWave2 {("G1" 6)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G1" 6)}
wvSetPosition -win $_nWave2 {("G1" 7)}
wvSelectSignal -win $_nWave2 {( "G1" 7 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 7 8 )} 
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSetPosition -win $_nWave2 {("G1" 8)}
wvSetPosition -win $_nWave2 {("G1" 9)}
wvSetPosition -win $_nWave2 {("G2" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSelectSignal -win $_nWave2 {( "G1" 8 )} 
wvSetPosition -win $_nWave2 {("G2" 0)}
wvSetPosition -win $_nWave2 {("G2" 1)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSetPosition -win $_nWave2 {("G3" 1)}
wvSelectGroup -win $_nWave2 {G4}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSelectGroup -win $_nWave2 {G4}
wvZoom -win $_nWave2 58101233.630693 1205600597.836887
wvZoom -win $_nWave2 971559631.621313 1006491119.116174
wvZoom -win $_nWave2 989246909.409160 990079877.401173
wvZoom -win $_nWave2 989568517.040720 989591760.693465
wvSetCursor -win $_nWave2 989574496.001604
wvSelectSignal -win $_nWave2 {( "G2" 3 )} 
srcHBSelect "uart_tb.dut.u_uart_rx" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "uart_tb.dut.u_uart_tx" -win $_nTrace1
wvUndo -win $_nWave2
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
verdiSetActWin -win $_nWave2
wvSelectGroup -win $_nWave2 {G4}
wvSelectGroup -win $_nWave2 {G3}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSelectGroup -win $_nWave2 {G3}
wvSelectSignal -win $_nWave2 {( "G3" 1 )} 
wvSetPosition -win $_nWave2 {("G3" 0)}
wvSetPosition -win $_nWave2 {("G2" 2)}
wvMoveSelected -win $_nWave2
wvSetPosition -win $_nWave2 {("G2" 2)}
wvSetPosition -win $_nWave2 {("G2" 3)}
wvSelectGroup -win $_nWave2 {G4}
srcHBSelect "uart_tb.dut.u_uart_tx" -win $_nTrace1
verdiSetActWin -dock widgetDock_<Inst._Tree>
srcHBSelect "uart_tb.dut.u_uart_rx" -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.rx_drv_cb" -win $_nTrace1
srcHBSelect "uvm_custom_install_recording" -win $_nTrace1
srcHBSelect "uart_tb.dut.u_uart_tx" -win $_nTrace1
srcHBSelect "uart_tb.dut.u_uart_rx" -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.mon_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.mon_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.rx_drv_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.rx_drv_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.rx_drv_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if.tx_drv_cb" -win $_nTrace1
srcSetScope "uart_tb.u_if.tx_drv_cb" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if.tx_drv_cb" -win $_nTrace1
srcHBSelect "uart_tb.u_if" -win $_nTrace1
srcSetScope "uart_tb.u_if" -delim "." -win $_nTrace1
srcHBSelect "uart_tb.u_if" -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 28 -pos 3 -win $_nTrace1
verdiSetActWin -dock widgetDock_MTB_SOURCE_TAB_1
verdiHighlightSignal -sigColor { "uart_tb.u_if.rx_drv_cb.rx_done" N/A }
verdiHighlightSignal -sigColor { "uart_tb.u_if.rx_drv_cb.rx_done" ID_RED5 }
verdiHighlightSignal -apply
srcDeselectAll -win $_nTrace1
srcDeselectAll -win $_nTrace1
srcSelect -word -line 28 -pos 3 -win $_nTrace1
srcShowDefine -win $_nTrace1
srcDeselectAll -win $_nTrace1
verdiSetActWin -win $_nWave2
wvZoom -win $_nWave2 989574908.750384 989575085.642719
wvZoom -win $_nWave2 989574998.946544 989575001.279979
wvZoom -win $_nWave2 989574999.984766 989575000.017915
wvZoom -win $_nWave2 989574999.990788 989575000.006009
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 989660453.316677 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 989671359.358280 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 989574135.987402
wvZoom -win $_nWave2 989574667.989432 989579057.006174
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 989620044.543738 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 989487790.620662 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 989574154.712670
wvSetCursor -win $_nWave2 989573014.592644 -snap {("G1" 4)}
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvZoomOut -win $_nWave2
wvSetCursor -win $_nWave2 942998696.594416 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 877035912.340230 -snap {("G4" 0)}
wvSetCursor -win $_nWave2 850475676.202483 -snap {("G4" 0)}
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSelectGroup -win $_nWave2 {G4}
wvSelectSignal -win $_nWave2 {( "G2" 2 )} 
wvSelectSignal -win $_nWave2 {( "G2" 1 )} 
wvSelectSignal -win $_nWave2 {( "G2" 2 )} 
wvSelectSignal -win $_nWave2 {( "G2" 3 )} 
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchPrev -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchNext -win $_nWave2
wvSearchPrev -win $_nWave2
