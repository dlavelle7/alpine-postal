FROM alpine:3.6

# Install libpostal dependencies
RUN apk update && apk add python3 py3-pip python3-dev curl autoconf automake \
        libtool pkgconfig make g++

RUN mkdir /postal /datadir /postal_tests

# Copy over libpostal submodule code
COPY libpostal/ /postal/libpostal/

WORKDIR /postal/libpostal

# Install postal
RUN ./bootstrap.sh && ./configure --datadir=/datadir && make && make install

#### Install python postal library ###
RUN pip3 install --upgrade pip && pip3 install postal==1.1.7

# Copy test code to container
COPY test_postal.py /postal_tests

# Test libpostal and postal were installed correctly
CMD ["python3", "/postal_tests/test_postal.py"]
