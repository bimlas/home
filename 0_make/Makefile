# Makefile - dotfiles bootstraping
#
# On Windows open a git-bash, cd here, then make it.
#
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.01.28 13:08 ==

LN_COMMON  = bin            \
             .ctags         \
             .gitconfig     \
             .gvimrc        \
             .pentadactylrc \
             .vimperatorrc  \
             .vimrc

LN_LINUX   = .bashrc        \
             .conkyrc       \
             .inputrc       \
             .profile       \
             .sh_commons    \
             .Xresources    \
             .xsessionrc    \
             .zshrc

CP_COMMON  = .dosbox        \
             .git_template

CP_LINUX   = .config        \
             .kde

# ============================================================================

CWD        = $(shell pwd)
LN         = ln -sf
CP         = cp --backup

ifeq ($(OS),Windows_NT)
  SYMLINKS = LN_COMMON
  COPIES   = CP_COMMON
else
  SYMLINKS = LN_COMMON LN_LINUX
  COPIES   = CP_COMMON CP_LINUX
endif

# all: install

# install: $(SYMLINKS) $(COPIES)

$(SYMLINKS):
	test -e $(CWD)/$@ && $(LN) $(CWD)/$@ ~/.$@

$(COPIES):
	test -e $(CWD)/$@ && $(CP) $(CWD)/$@ ~/.$@
