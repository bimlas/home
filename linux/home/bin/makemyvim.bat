@echo off
rem Copy to vim-src/src

mingw32-make -f Make_cyg_ming.mak ^
UNDER_CYGWIN=no                   ^
FEATURES=HUGE                     ^
ARCH=i586                         ^
OLE=yes                           ^
GUI=yes                           ^
PYTHON=c:/app/python27            ^
PYTHON_VER=27                     ^
PYTHON3=c:/app/python34           ^
PYTHON3_VER=34                    ^
RUBY=c:/app/ruby22                ^
RUBY_VER=22                       ^
RUBY_VER_LONG=2.2.0               ^
LUA=c:/app/lua                    ^
LUA_VER=53                        ^
PERL=c:/app/perl                  ^
PERL_VER=522                      ^
TCL=c:/app/tcl                    ^
TCL_VER=86
