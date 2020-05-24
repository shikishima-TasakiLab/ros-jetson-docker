FROM nvcr.io/nvidia/l4t-base:r32.3.1

LABEL maintainer="Shikishima-TasakiLab"

ARG ROS_DISTRO="melodic"
ARG HOST_USER="1000"
ARG USER_NAME="ros"

SHELL ["/bin/bash", "-c"]

RUN useradd -m $USER_NAME && \
    echo "$USER_NAME:$USER_NAME" | chpasswd && \
    usermod --shell /bin/bash $USER_NAME && \
    usermod -aG sudo $USER_NAME && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    usermod  --uid $HOST_USER $USER_NAME && \
    groupmod --gid $HOST_USER $USER_NAME && \
    gpasswd -a $USER_NAME video

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        sudo \
        build-essential \
        git \
        less \
        emacs \
        tmux \
        bash-completion \
        command-not-found \
        software-properties-common \
        cmake-curses-gui \
        cmake-qt-gui \
        dbus-x11 \
        dmz-cursor-theme \
        fonts-dejavu \
        gconf2 \
        gnome-terminal \
        gosu \
        language-pack-en \
        xdg-user-dirs \
        xsel \
        dirmngr \
        gpg-agent \
        mesa-utils \
        libarmadillo-dev \
        libcanberra-gtk-module \
        libcanberra-gtk3-0 \
        libcanberra-gtk3-module \
        libglu1-mesa-dev \
        libgles2-mesa-dev \
        freeglut3-dev \
        libdbus-glib-1-2 \
        libgflags-dev \
        libglew-dev \
        libgoogle-glog-dev \
        libgoogle-perftools-dev \
        libgsl0-dev \
        libmosquitto-dev \
        libopencv-dev \
        libopenni2-dev \
        libpcap-dev \
        libssh2-1-dev \
        locales \
        pulseaudio \
        python-flask \
        python-requests \
        python3-pip \
        python3-setuptools \
        tmux \
        v4l-utils \
        nano \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list && \
    apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        ros-${ROS_DISTRO}-desktop-full \
        python-rosdep \
        python-rosinstall \
        python-rosinstall-generator \
        python-wstool \
        python3-vcstool \
        python3-colcon-common-extensions \
        build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN update-locale LANG=en_US.UTF-8 LC_MESSAGES=POSIX

ENV LANG="en_US.UTF-8"
RUN echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> /etc/profile.d/ros.sh && \
    echo "export QT_X11_NO_MITSHM=1" >> /etc/profile.d/ros.sh && \
    echo "export LANG=\"en_US.UTF-8\"" >> /etc/profile.d/ros.sh

RUN rosdep init

COPY ./entrypoint.sh /tmp
RUN chmod +x /tmp/entrypoint.sh

USER ${USER_NAME}
WORKDIR /home/${USER_NAME}
ENV ROSDISTRO ${ROS_DISTRO}

RUN source /opt/ros/${ROSDISTRO}/setup.bash && \
    rosdep update && \
    echo "source /opt/ros/${ROSDISTRO}/setup.bash" >> /home/${USER_NAME}/.bashrc && \
    echo "export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH" >> /home/${USER_NAME}/.bashrc && \
    mkdir /home/ros/catkin_ws

WORKDIR /home/ros/catkin_ws

ENTRYPOINT ["/tmp/entrypoint.sh"]
