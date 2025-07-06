FROM ubuntu:18.10

# Set environment variables to avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Replace servers
RUN echo "deb http://old-releases.ubuntu.com/ubuntu/ cosmic main restricted universe multiverse" >/etc/apt/sources.list \
    && echo "deb http://old-releases.ubuntu.com/ubuntu/ cosmic-updates main restricted universe multiverse" >>/etc/apt/sources.list \
    && echo "deb http://old-releases.ubuntu.com/ubuntu/ cosmic-security main restricted universe multiverse" >>/etc/apt/sources.list \
    && echo "deb http://old-releases.ubuntu.com/ubuntu/ cosmic-backports main restricted universe multiverse" >>/etc/apt/sources.list \
    && apt-mark hold libc6 libstdc++6 \
    && dpkg --add-architecture armhf && apt-get -y update && apt-get -y upgrade \
    && apt-get -y install ca-certificates build-essential binutils-multiarch gcc-multilib g++-multilib \
    && apt-get -y install \
    bc \
    bison \
    curl \
    dpkg-dev \
    g++ \
    g++-arm-linux-gnueabihf \
    gawk \
    gcc \
    gcc-arm-linux-gnueabihf \
    gdb \
    gettext \
    git \
    libasound2-dev \
    libavcodec-dev \
    libavformat-dev \
    libdrm-dev \
    libegl1-mesa-dev \
    libfreetype6-dev \
    libgbm-dev \
    libgl1-mesa-dev \
    libgles2-mesa-dev \
    libjpeg-dev \
    libpng-dev \
    libpulse-dev \
    libssl-dev \
    libswscale-dev \
    libudev-dev \
    libvulkan-dev \
    libx11-dev \
    libxext-dev \
    libxi-dev \
    libxrandr-dev \
    python3-dev \
    python3-pip \
    sed \
    texinfo \
    wget \
    zip \
    zlib1g-dev \
    libgles2-mesa-dev:armhf \
    libsdl2-dev:armhf \
    libsdl2-image-dev:armhf \
    libudev-dev:armhf

# Set the default command
CMD ["/bin/bash"]
