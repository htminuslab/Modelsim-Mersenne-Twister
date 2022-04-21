@REM Using Modelsim's gcc compiler
vdel -all
vlib work
 
gcc -g -c -Wall -I. -I%MTI_HOME%/include  src/fli_mt.c
gcc -shared -lm -o  fli_mt.dll fli_mt.o  -L%MTI_HOME%/win64pe -lmtipli
 
vcom -nostats -quiet -2008 rtl\tb.vhd
vsim -nostats -quiet tb -c -do "run 100 ns; quit -f"