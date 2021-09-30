FROM ubuntu:18.04

RUN apt-get update -y \
  && apt-get install -y \
    sudo \
    curl \
    wget \
    git \
    python-minimal \
    build-essential \
    virtualenv \
    bison \
    flex \
    autoconf \
    automake \
    libtool \
    texinfo \
    pkg-config \
    gettext \
  && rm -rf /var/lib/apt/lists/*

COPY /SHARPE /sharpe
ENV PKG_CONFIG_PATH /sharpe/exlibs/cln
RUN mkdir -p /sharpe/exlibs

RUN git clone git://www.ginac.de/cln.git /sharpe/exlibs/cln &&\
    cd /sharpe/exlibs/cln &&\
    mkdir -p /sharpe/exlibs/cln/build-aux &&\
    touch /sharpe/exlibs/cln/build-aux/config.rpath &&\
    autoreconf --install &&\
    ./configure --prefix=/sharpe/exlibs &&\
    make && make install

RUN mkdir -p /sharpe/exlibs/gmp &&\
    wget -O /tmp/gmp.tar.xz https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz &&\
    tar xvf /tmp/gmp.tar.xz -C /sharpe/exlibs/gmp --strip-components 1 &&\
    rm /tmp/gmp.tar.xz &&\
    cd /sharpe/exlibs/gmp &&\
    autoreconf --install &&\
    ./configure --prefix=/sharpe/exlibs &&\
    make && make install

RUN git clone git://www.ginac.de/ginac.git /sharpe/exlibs/ginac &&\
    cd /sharpe/exlibs/ginac &&\
    virtualenv -p python2.7 venv &&\
    . venv/bin/activate &&\
    autoreconf --install &&\
    ./configure --disable-shared --prefix=/sharpe/exlibs &&\
    make && make install &&\
    deactivate

ARG config="release"
RUN cd /sharpe &&\
    python ./genmake.py &&\
    make config=$config &&\
    mv ./build/$config/sharpe /usr/local/bin/sharpe

RUN rm -fR /sharpe

WORKDIR /app
ENTRYPOINT ["/usr/local/bin/sharpe"]
CMD ["-h"]
