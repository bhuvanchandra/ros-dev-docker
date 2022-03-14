#FROM rrdockerhub/ros-base-noetic-amd64:0b33e61-20201008
#FROM ros:noetic-ros-base-bionic
FROM ros:noetic-ros-base-focal
LABEL maintainer="Bhuvanchandra DV <bhuvanchandra.dv@rapyuta-robotics.com>"

ENV DEBIAN_FRONTEND=noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE=DontWarn

ARG USER=dvb

RUN echo 'Asia/Tokyo' > /etc/timezone

ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends apt-utils software-properties-common && \
    add-apt-repository ppa:apt-fast/stable -y && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends apt-fast


RUN apt-fast install -y --no-install-recommends\
    ca-certificates \
    gnupg2 \
    unzip \
    ssh \
    sudo \
    lighttpd \
    vim \
    curl \
    wget \
    git-lfs \
    apt-transport-https \
    iproute2 \
    can-utils \
    zsh \
    openocd \
    cmake-curses-gui \
    bash-completion

RUN rosdep update && apt-fast install -y --no-install-recommends \
    ros-noetic-rosauth \
    ros-noetic-tf \
    ros-noetic-map-server \
    ros-noetic-robot-state-publisher \
    ros-noetic-tf2-eigen \
    ros-noetic-urg-node \
    ros-noetic-move-base \
    ros-noetic-xacro \
    ros-noetic-diagnostic-updater \
    ros-noetic-pcl-conversions \
    ros-noetic-rosfmt \
    ros-noetic-global-planner \
    ros-noetic-tf2-msgs \
    ros-noetic-laser-geometry \
    ros-noetic-rviz \
    ros-noetic-rqt-gui-cpp \
    ros-noetic-rqt-gui \
    ros-noetic-joy \
    ros-noetic-laser-filters \
    ros-noetic-catch-ros \
    ros-noetic-map-msgs \
    ros-noetic-tf2-geometry-msgs \
    ros-noetic-turtlesim \
    ros-noetic-interactive-markers \
    ros-noetic-move-base-msgs \
    ros-noetic-tf2 \
    ros-noetic-teleop-twist-joy \
    ros-noetic-image-transport \
    ros-noetic-angles \
    ros-noetic-cv-bridge \
    ros-noetic-rospy-tutorials \
    ros-noetic-robot-localization \
    ros-noetic-nav-core \
    ros-noetic-pcl-ros \
    ros-noetic-tf2-ros \
    ros-noetic-spatio-temporal-voxel-layer \
    ros-noetic-gmapping \
    ros-noetic-ddynamic-reconfigure \
    ros-noetic-voxel-grid \
    ros-noetic-roslint \
    ros-noetic-controller-manager \
    ros-noetic-gazebo-* \
    ros-noetic-rqt-* \
    ros-noetic-velocity-controllers \
    ros-noetic-joint-state-controller \
    ros-noetic-joint-state-publisher \
    ros-noetic-roslint \
    ros-noetic-controller-manager \
    ros-noetic-can-msgs \
    ros-noetic-diff-drive-controller \
    ros-noetic-socketcan-bridge \
    rapidjson-dev \
    ros-noetic-effort-controllers \
    ros-noetic-ira-laser-tools \
    ros-noetic-joy-teleop \
    ros-noetic-teleop-tools-msgs \
    ros-noetic-gazebo-ros \
    ros-noetic-gazebo-plugins \
    ros-noetic-tf2-sensor-msgs && \
    apt-get autoremove -y


RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 -P /tmp && tar xvjf /tmp/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 -C /opt

RUN id $USER 2>/dev/null || useradd --create-home $USER
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN usermod -aG sudo,audio,plugdev,video,tty,dialout $USER
USER $USER

WORKDIR /home/$USER/

CMD "/bin/zsh"
