@echo off
rem Copy to vim source root.

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
RUBY_VER_LONG=2.2.0               ^
rem PERL=c:/app/app/perl              ^
rem PERL_VER=56                       ^
rem TCL=c:/app/app/tcl                ^
rem TCL_VER = 83                      ^

cd ..
