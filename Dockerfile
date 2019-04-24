FROM alpine:3.6

RUN mkdir /postal /datadir /postal_tests

# Copy over libpostal submodule code
COPY libpostal/ /postal/libpostal/

WORKDIR /postal/libpostal

# Install libpostal dependencies, install libpostal and remove dependencies
RUN apk update && apk add python3 py3-pip python3-dev curl autoconf automake \
        libtool pkgconfig make g++ && \
    ./bootstrap.sh && ./configure --datadir=/datadir && make && \
        make install && \
    apk del --purge autoconf automake libtool pkgconfig make

COPY run_postal_tests.sh /postal_tests/

# Test libpostal and postal were installed correctly
CMD ["sh", "/postal_tests/run_postal_tests.sh"]
