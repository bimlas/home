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
# ========== BimbaLaszlo (.github.io|gmail.com) ========== 2015.06.05 08:44 ==

FROM debian:testing
MAINTAINER BimbaLaszlo

RUN apt-get update

RUN apt-get install -y curl

RUN apt-get install -y gcc g++ make
RUN apt-get install -y ctags
RUN apt-get install -y git

RUN apt-get install -y python python-pip python3 python3-pip

RUN apt-get install -y ruby ruby-dev
RUN gem install gem-ctags ripper-tags
RUN gem install pry byebug

#                        SET UP USER ENVIRONMENT
# ============================================================================

RUN apt-get install -y zsh
# RUN git clone https://github.com/zsh-users/antigen ~/.antigen
# RUN zsh
# RUN source ~/antigen/antigen.zsh
# RUN antigen bundle git

# RUN git clone https://github.com/BimbaLaszlo/home ~/home
# RUN cd ~/home; chmod 744 linux_user.sh; ./linux_user.sh
# mount?
