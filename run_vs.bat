@REM Using Visual Studio cl compiler
vdel -all
vlib work
 
cl -c /Zi -I %MTI_HOME%\include src/fli_mt.c
link -dll -export:get_rand64 -export:init_genrand64 fli_mt.obj %MTI_HOME%\win64pe\mtipli.lib /out:fli_mt.dll 
 
vcom -nostats -quiet -2008 rtl\tb.vhd
vsim -nostats -quiet tb -c -do "run 100 ns; quit -f"