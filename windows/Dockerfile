# USE PLAIN VIRTUALBOX for developement environment - Docker doesn't handles
# terminal well, for example Vim diff mode is laggy and smacks up the screen.
#
# To use with Conemu, start `boot2docker ssh` and run the commands in it.
# Related issues:
#   https://github.com/Maximus5/ConEmu/issues/183
#   https://github.com/docker/docker/issues/13817
#
# INSTALL PREBUILD IMAGE
#   $ docker run   -it --name my-image -d install-from-group/image:tag
#
# BUILD FROM DOCKERFILE
#   $ docker build -t  mylinux dir_of_dockerfile
#   $ docker run   -it mylinux /bin/bash
#   To rebuild the whole image, add `--no-cache` to the build command.
#
# HISTORY OF IMAGE
#   $ docker history mylinux
#   Revert changes:
#   $ docker tag SHA mylinux
#
# RUN WITH MOUNTED FILESYSTEM
#   $ docker run -v /path/on/host:/path/in/container -it mylinux /bin/bash
#   If you using Boot2Docker on Windows, then use double-slash:
#   $ docker run -v //path/on/vm://path/in/container -it mylinux /bin/bash
#   For example:
#   $ docker run -v //c/users/you/documents://root/mnt -it mylinux /bin/bash
#
# COMMIT CHANGES
#   Press ^C ^Q inside the running container, than
#   $ docker ps
#   $ docker commit SHA mylinux
#
# REMOVE IMAGE
#   docker images
#   docker rmi name_of_image
#
# ==================== BimbaLaszlo (.github.io|gmail.com) ====================

FROM debian:testing
MAINTAINER BimbaLaszlo

RUN apt-get update
RUN apt-get install -y zsh
RUN apt-get install -y git

#                              DEVELOPEMENT                               {{{1
# ============================================================================

RUN apt-get install -y gcc make
RUN apt-get install -y ctags

RUN apt-get install -y python python-pip python3 python3-pip

RUN apt-get install -y ruby ruby-dev
RUN gem install ripper-tags gem-ripper-tags
RUN gem install pry

#                         SET UP USER ENVIRONMENT                         {{{1
# ============================================================================

# ENV TERM=xterm

RUN git clone --progress --verbose --depth 1 https://github.com/BimbaLaszlo/home ~/home
# It's a bash script, not works with /bin/sh!
RUN /bin/bash /root/home/linux_user.sh
RUN chmod 744 /root/bin/*

# RUN vim -c 'InstallNeoBundle' -c 'qa!'
# RUN vim -c 'NeoBundleInstall' -c 'qa!'
# mount?

#                                BUILD VIM                                {{{1
# ============================================================================

RUN apt-get install -y python-dev python3-dev ruby-dev liblua5.3-dev libperl-dev
RUN git clone --progress --verbose --depth 1 https://www.github.com/vim/vim /root/src/vim
RUN cd /root/src/vim && /root/bin/makemyvim.sh && make && make install && cd -
