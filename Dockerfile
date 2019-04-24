FROM alpine:3.6

RUN mkdir /code /datadir /postal_tests

WORKDIR /code/

# Install libpostal deps, libpostal & uninstall build time deps in one
# chained RUN to reduce image size (one layer).
# Note: alpine xargs doesn't have -P option (parallel), hence sed command
RUN apk update && apk add git python3 py3-pip python3-dev curl autoconf \
        automake libtool pkgconfig make g++ && \
    git clone https://github.com/openvenues/libpostal && \
    cd libpostal && \
    sed -i 's/ -P $NUM_WORKERS//' src/libpostal_data.in && \
    ./bootstrap.sh && ./configure --datadir=/datadir && \
    make && make install && \
    apk del --purge git autoconf automake libtool pkgconfig make && \
    cd && rm -rf /code/libpostal

# Test python postal library
COPY run_postal_tests.sh /postal_tests/
CMD ["sh", "/postal_tests/run_postal_tests.sh"]
