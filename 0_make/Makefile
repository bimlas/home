# Makefile - dotfiles bootstraping
#
# On Windows open a git-bash, cd here, then make it.
#
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.01.28 21:32 ==

LN_HOME_COMMON = bin                 \
                 .git_template       \
                 .ctags              \
                 .gitconfig          \
                 .gvimrc             \
                 .pentadactylrc      \
                 .vimperatorrc       \
                 .vimrc

LN_HOME_LINUX  = .bashrc             \
                 .conkyrc            \
                 .inputrc            \
                 .profile            \
                 .sh_commons         \
                 .Xresources         \
                 .xsessionrc         \
                 .zshrc

CP_HOME_COMMON = .dosbox/dosbox-0.74

CP_HOME_LINUX  = .config             \
                 .kde

# ============================================================================

CWD = $(shell pwd)
LN  = test -e $(1) && ln -sf $(1) $(2)
CP  = test -e $(1) && cp --parents $(1) $(2)

ifeq ($(OS),Windows_NT)
  SYMLINKS = $(LN_HOME_COMMON)
  COPIES   = $(CP_HOME_COMMON)
else
  SYMLINKS = $(LN_HOME_COMMON) $(LN_HOME_LINUX)
  COPIES   = $(CP_HOME_COMMON) $(CP_HOME_LINUX)
endif

all: install

install: $(SYMLINKS) $(COPIES)

target:
	@while read -r file; do \
	  test -e "$$file" && echo "$$file"; \
	done <lista

$(SYMLINKS):
	$(call LN, $(CWD)/home/$@, ~/$@)

$(COPIES):
	$(call CP, $(CWD)/home/$@, ~)
