# To use with Conemu, start `boot2docker ssh` amd run the commands in it.
#
# docker build -t  debiam dir_of_dockerfile
# docker run   -it debiam /bin/bash
#
# Run with mounted filesystem:
#   docker run -v /path/on/host:/path/in/container -it debiam /bin/bash
# If you using Boot2Docker on Windows, then use double-slash:
#   docker run -v //path/on/vm://path/in/container -it debiam /bin/bash
# For example:
#   docker run -v //c/users/you/documents://root/mnt -it debiam /bin/bash
#
# Remove image:
#   docker images
#   docker rmi name_of_image
#
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.08.06 22:31 ==

FROM debian:testing
MAINTAINER BimbaLaszlo

RUN apt-get update
RUN apt-get install -y git

RUN apt-get install -y vim
RUN vim -c 'InstallVundle'
RUN vim -c 'PluginInstall'

RUN apt-get install -y gcc g++ make
RUN apt-get install -y ctags

RUN apt-get install -y python python-pip python3 python3-pip

RUN apt-get install -y ruby ruby-dev
RUN gem install ripper-tags gem-ripper-tags
RUN gem install pry byebug

#                        SET UP USER ENVIRONMENT
# ============================================================================

# ENV TERM=xterm

RUN git clone --progress --verbose https://github.com/BimbaLaszlo/home ~/home
# It's a bash script, not works with /bin/sh!
RUN /bin/bash -c "cd /root/home; source ./linux_user.sh"
# mount?

RUN apt-get install -y zsh
RUN git clone --progress --verbose https://github.com/zsh-users/antigen ~/.antigen/antigen
RUN /bin/zsh -c "source /root/.antigen/antigen/antigen.zsh; antigen bundle git"
