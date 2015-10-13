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
rem DOWNLOADABLE BUILD
rem   https://github.com/BimbaLaszlo/home/releases/tag/gvim.exe
rem
rem =================== BimbaLaszlo (.github.io|gmail.com) ===================

mingw32-make -f Make_cyg_ming.mak ^
USERNAME=BimbaLaszlo              ^
USERDOMAIN=                       ^
UNDER_CYGWIN=no                   ^
FEATURES=HUGE                     ^
ARCH=i586                         ^
OLE=yes                           ^
GUI=yes                           ^
PYTHON=c:/app/python2             ^
PYTHON_VER=27                     ^
PYTHON3=c:/app/python3            ^
PYTHON3_VER=35                    ^
RUBY=c:/app/ruby                  ^
RUBY_VER=22                       ^
RUBY_VER_LONG=2.2.0               ^
LUA=c:/app/lua                    ^
LUA_VER=53                        ^
PERL=c:/app/perl                  ^
PERL_VER=522                      ^
TCL=c:/app/tcl                    ^
TCL_VER=86
