REM Copy to vim source root.
REM
REM PERL=c:/perl
REM PERL_VER=56
REM TCL=c:/tcl
REM TCL_VER = 83

cd %~dp0\src
mingw32-make -f Make_cyg_ming.mak UNDER_CYGWIN=no FEATURES=HUGE ARCH=i586 GUI=yes LUA=c:/lua52 LUA_VER=52 PYTHON=c:/python27 PYTHON_VER=27 PYTHON3=c:/python34 PYTHON3_VER=34 RUBY=c:/ruby21 RUBY_VER=21 RUBY_VER_LONG=2.1.0
cd ..
