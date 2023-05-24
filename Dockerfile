FROM ubuntu:latest

# system base packages + build dependencies + user setup ~350MB
RUN set -xe \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential\
	nano\
	bash\
	ca-certificates\
	openssh-client\
	libisl-dev\
        subversion\
	g++\
	zlib1g-dev\
	git\
	python2\
	python3\
        rsync\
	libncurses5-dev\
	gawk\
	gettext\
	unzip\
	file\
	libssl-dev\
	wget\
	zip\
	time\
	clang\
	flex\
	bison\
	gcc-multilib\
	g++-multilib\
	git\
	gcc\
	libncurses-dev\
	libssl-dev\
	python3-distutils\
	zlib1g-dev\
    && rm -rf /var/lib/apt/lists/* \
    && useradd build \
    && mkdir /home/build \
    && chown build:build /home/build

# run as build user
USER build

# clone openwrt repo ~200MB
RUN set -xe \
    && cd /home/build \
    && git clone https://git.openwrt.org/openwrt/openwrt.git openwrt

# checkout v18.06.8 stable
ARG GIT_REVISION=openwrt-23.05

# fetch branch/tag and update feeds ~100MB
RUN set -xe \
    && mkdir -p /home/build/openwrt/bin/targets \
    && cd /home/build/openwrt \
    && git checkout ${GIT_REVISION}

# copy related configs
COPY conf/ /home/build/conf
# copy pakcges sources
COPY package/ /home/build/openwrt/package
# working dir
WORKDIR /home/build/openwrt
RUN ./scripts/feeds update -a && ./scripts/feeds install -a
ENV FORCE_UNSAFE_CONFIGURE=1
# start bash
ENTRYPOINT [ "/bin/bash" ]
