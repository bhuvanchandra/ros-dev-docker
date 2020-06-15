FROM rrdockerhub/ros-base-melodic-amd64:20190919
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
    python-catkin-tools \
    python-pip \
    git-lfs \
    apt-transport-https \
    iproute2 \
    can-utils \
    docker.io \
    zsh \
    bash-completion

RUN apt-fast install -y --no-install-recommends \
    supervisor \
    libeigen3-dev \
    nmap \
    libtinyxml2-dev \
    python-autobahn \
    udev \
    libsdl1.2-dev \
    python-twisted-core \
    libftdi-dev \
    libpcl-dev \
    libcurl4-openssl-dev \
    libjsoncpp-dev \
    python-paramiko \
    python-jinja2 \
    python-yaml \
    docker-compose \
    libqt4-dev \
    openssh-server \
    libgtest-dev \
    libevdev-dev \
    libyaml-cpp-dev \
    python3-pip \
    python-scp \
    libboost-all-dev \
    libqt5core5a \
    liblua5.1-0-dev \
    python-tornado \
    libqt5widgets5 \
    sshpass \
    python-dev \
    qtbase5-dev \
    python-ruamel.yaml \
    lighttpd \
    python-rospkg \
    libopencv-dev \
    libcpprest-dev \
    libncurses5-dev \
    python-enum34 \
    golang-go \
    python-flask \
    libpcl-apps1.8 \
    libpcl-common1.8 \
    libpcl-features1.8 \
    libpcl-filters1.8 \
    libpcl-io1.8 \
    libpcl-kdtree1.8 \
    libpcl-keypoints1.8 \
    libpcl-ml1.8 \
    libpcl-octree1.8 \
    libpcl-outofcore1.8 \
    libpcl-people1.8 \
    libpcl-recognition1.8 \
    libpcl-registration1.8 \
    libpcl-sample-consensus1.8 \
    libpcl-search1.8 \
    libpcl-segmentation1.8 \
    libpcl-stereo1.8 \
    libpcl-surface1.8 \
    libpcl-tracking1.8 \
    libpcl-visualization1.8 \
    iputils-ping \
    python-bson \
    google-mock \
    postgresql \
    postgresql-contrib \
    gamin \
    libbullet-dev \
    libsdl2-dev \
    libogre-1.9-dev \
    python-backports.ssl-match-hostname \
    openssl \
    python-pil \
    libsdl-image1.2-dev \
    libqt5gui5 \
    libsdl2-mixer-dev \
    python-requests \
    cmake-curses-gui \
    openocd \
    libeigen3-dev \
    libftdi-dev \
    libmuparser-dev \
    python3-requests && \
    apt-get autoremove -y

# Save time by using rosdep install -i --simulate --reinstall --from-paths src
RUN rosdep update && apt-fast install -y --no-install-recommends \
    ros-melodic-rosauth \
    ros-melodic-tf \
    ros-melodic-map-server \
    ros-melodic-robot-state-publisher \
    ros-melodic-tf2-eigen \
    ros-melodic-urg-node \
    ros-melodic-move-base \
    ros-melodic-xacro \
    ros-melodic-diagnostic-updater \
    ros-melodic-pcl-conversions \
    ros-melodic-rosfmt \
    ros-melodic-global-planner \
    ros-melodic-tf2-msgs \
    ros-melodic-laser-geometry \
    ros-melodic-rviz \
    ros-melodic-rqt-gui-cpp \
    ros-melodic-rqt-gui \
    ros-melodic-joy \
    ros-melodic-laser-filters \
    ros-melodic-catch-ros \
    ros-melodic-map-msgs \
    ros-melodic-tf2-geometry-msgs \
    ros-melodic-turtlesim \
    ros-melodic-yocs-cmd-vel-mux \
    ros-melodic-interactive-markers \
    ros-melodic-move-base-msgs \
    ros-melodic-tf2 \
    ros-melodic-teleop-twist-joy \
    ros-melodic-image-transport \
    ros-melodic-angles \
    ros-melodic-cv-bridge \
    ros-melodic-rospy-tutorials \
    ros-melodic-robot-localization \
    ros-melodic-nav-core \
    ros-melodic-pcl-ros \
    ros-melodic-tf2-ros \
    ros-melodic-spatio-temporal-voxel-layer \
    ros-melodic-gmapping \
    ros-melodic-ddynamic-reconfigure \
    ros-melodic-voxel-grid \
    ros-melodic-roslint \
    ros-melodic-controller-manager \
    ros-melodic-gazebo-* \
    ros-melodic-rqt-* \
    ros-melodic-velocity-controllers \
    ros-melodic-joint-state-controller \
    ros-melodic-joint-state-publisher \
    ros-melodic-roslint \
    ros-melodic-controller-manager \
    ros-melodic-can-msgs \
    ros-melodic-diff-drive-controller \
    ros-melodic-socketcan-bridge \
    rapidjson-dev \
    ros-melodic-effort-controllers \
    ros-melodic-ira-laser-tools \
    ros-melodic-joy-teleop \
    ros-melodic-teleop-tools-msgs \
    ros-melodic-tf2-sensor-msgs && \
    apt-get autoremove -y


RUN wget https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-rm/8-2019q3/RC1.1/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 -P /tmp && tar xvjf /tmp/gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2 -C /opt

RUN id $USER 2>/dev/null || useradd --create-home $USER
RUN echo "$USER ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN usermod -aG docker $USER
USER $USER

WORKDIR /home/$USER/

CMD "/bin/zsh"
