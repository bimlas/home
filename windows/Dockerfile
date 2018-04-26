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
# PREVENT SENDING ENTIRE DIRECTORY TO DOCKER MACHINE
#   If the Dockerfile is placed in to a huge directory, but you need only a
#   specific subdirectory, then pass it as a parameter to the build command to
#   prevent the sending of the huge dir (`Sending build context to Docker
#   daemon`).
#   $ docker build -t my-image ./subdir
#
#   If the build fails, you can see what happened by opening the last image
#   container:
#
#   Removing intermediate container 13c13c71cf8d
#    ---> 0dd860f784ed
#   Step 22/22 : RUN composer install
#    ---> Running in 79e8407ced6e
#   Do not run Composer as root/super user! See https://getcomposer.org/root for details
#   $ docker run -it 0dd860f784ed /bin/bash
#
# DECOUPLE DOCKERFILE INTO MULTIPLE CONTAINERS
#   https://stackoverflow.com/a/43604959
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
RUN apt-get install -y neovim
RUN apt-get install -y git

#                              DEVELOPEMENT                               {{{1
# ============================================================================

RUN apt-get install -y gcc make
RUN apt-get install -y ctags

RUN apt-get install -y python python-pip python3 python3-pip
RUN pip install neovim
RUN pip3 install neovim

RUN apt-get install -y ruby ruby-dev
RUN gem install neovim
RUN gem install ripper-tags gem-ripper-tags
RUN gem install pry

#                         SET UP USER ENVIRONMENT                         {{{1
# ============================================================================

# ENV TERM=xterm

# CMD commands will run on executing container, but only one CMD is allowed!
CMD git clone --progress --verbose --depth 1 https://github.com/bimlas/home ~/home && \
    /bin/bash /root/home/linux_user.sh && \
    chmod 744 /root/bin/* && \
    vim -c 'InstallPluginManager' -c 'qa!' && \
    vim -c 'PlugInstall' -c 'qa!'
#mount?
