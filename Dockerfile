FROM ubuntu:22.04

# Declare arguments
ARG PASSWORD='root'
ARG ROS_VER='humble'

ENV DEBIAN_FRONTEND=noninteractive

# Install required packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash \
    git \
    ca-certificates \
    lsb-release

# Install ROS2
RUN git clone https://github.com/Rione/home_ros2_setup && \
    sed -i "s/ROS_VER=humble/ROS_VER=${ROS_VER}/g" home_ros2_setup/setup.bash && \
    sed -i 's/sudo //g' home_ros2_setup/setup.bash && \
    ./home_ros2_setup/setup.bash && \
    . ~/.bashrc && \
    echo "source /opt/ros/${ROS_VER}/setup.sh" >> ~/.bashrc

# Install additional packages (Optional)
RUN apt-get install -y --no-install-recommends \
    vim \
    tmux \
    openssh-server \
    python3-gst-1.0 \
    alsa-utils

# Copy tmux's config file
COPY .tmux.conf /root/ 

# Configure SSH daemon (Optional)
RUN mkdir /var/run/sshd && \
    echo "root:${PASSWORD}" | chpasswd && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

EXPOSE 22
WORKDIR /root/my_ws
CMD [ "/usr/sbin/sshd", "-D" ]