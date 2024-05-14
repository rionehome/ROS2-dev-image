FROM ubuntu:22.04

ARG PASSWORD='root'
ARG ROS_VER='iron'

ENV DEBIAN_FRONTEND=noninteractive

# Required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    lsb-release \
    python3-gst-1.0 \
    alsa-utils

# Install ROS2
RUN git clone https://github.com/Rione/home_ros2_setup && \
    sed -i "s/ROS_VER=humble/ROS_VER=${ROS_VER}/g" home_ros2_setup/setup.bash && \
    sed -i 's/sudo //g' home_ros2_setup/setup.bash && \
    ./home_ros2_setup/setup.bash && \
    . ~/.bashrc && \
    . /opt/ros/${ROS_VER}/setup.sh

# Additional packages
RUN apt-get install -y --no-install-recommends \
    vim \
    terminator \
    openssh-server

# Configure SSHd
RUN mkdir /var/run/sshd && \
    echo "root:${PASSWORD}" | chpasswd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

WORKDIR /root/my_ws

EXPOSE 22
CMD [ "/usr/sbin/sshd", "-D" ]