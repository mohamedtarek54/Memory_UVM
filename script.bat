:: configure shell window
color C
title Compiling Memory UVM
echo off
cls
echo;

echo script works as follow:
echo;
echo - delete any /work directory exists in current path
echo - create new work using "vlib work" command
echo - compile all Systemverilog files exist in current path
echo - open simulation in gui mode with some configurations
echo - configurations: 
echo -    - dont quit on finish
echo -    - add all interface signals to waveform
echo -    - simulation run -all
echo -    - report coverage
echo - after simulation window is closed, all logs are deleted(transcript, vsim.wlf, dump.vcd and work directory)
echo;
pause

echo deleting work directory...
RD /S /Q work
echo done
echo;

echo creating a new work directory...
vlib work
echo done
echo;

echo compiling all verilog files
vlog memory_pkg.sv top.sv intf.sv memory_16x32.sv +cover
echo done
echo;

echo opening simulation...
vsim top -coverage -do "set NoQuitOnFinish 1; add wave -position insertpoint sim:/top/intf1/*; run -all; coverage report -codeAll -cvg -verbose"
echo;

echo simulation is closed
echo deleting simulation logs...
DEL transcript
DEL vsim.wlf
DEL dump.vcd
RD /S /Q work
echo;
pause