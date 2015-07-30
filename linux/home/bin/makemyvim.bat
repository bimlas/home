@echo off
rem Vim Git repository: https://www.github.com/vim/vim
rem
rem Copy to vim/src.
rem
rem If something went wrong (for example need to upgrade packages) delete
rem everything except the .git dir, than `git reset --hard`.
rem
rem NOTE
rem   DIRECTX=yes needs mingw64 + ARCH=i686 (or x64)
rem
rem ========= BimbaLaszlo (.github.io|gmail.com) ========= 2015.07.30 21:40 ==

mingw32-make -f Make_cyg_ming.mak ^
USERNAME=BimbaLaszlo              ^
USERDOMAIN=                       ^
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
