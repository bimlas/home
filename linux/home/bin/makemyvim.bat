REM Copy to vim source root.
REM
REM PERL=c:/app/app/perl
REM PERL_VER=56
REM TCL=c:/app/app/tcl
REM TCL_VER = 83

cd %~dp0\src

mingw32-make -f Make_cyg_ming.mak ^
UNDER_CYGWIN=no                   ^
FEATURES=HUGE                     ^
ARCH=i586                         ^
GUI=yes                           ^
LUA=c:/app/lua                    ^
LUA_VER=53                        ^
PYTHON=c:/app/python27            ^
PYTHON_VER=27                     ^
PYTHON3=c:/app/python34           ^
PYTHON3_VER=34                    ^
RUBY=c:/app/ruby22                ^
RUBY_VER=22                       ^
RUBY_VER_LONG=2.2.0

cd ..
