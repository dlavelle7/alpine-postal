FROM alpine:3.6

RUN apk update && apk add python3 py3-pip python3-dev curl autoconf automake \
        libtool pkgconfig git make

RUN mkdir /postal /datadir /postal_tests

WORKDIR /postal

### Download, Compile & Install libpostal ###
RUN git clone https://github.com/openvenues/libpostal

# xargs in alpine doesn't have the `-P` option, so remove and use just one proc
# Stinky winky ;) https://github.com/openvenues/libpostal/issues/319
RUN sed -i 's/ -P $NUM_WORKERS//' libpostal/src/libpostal_data.in

WORKDIR /postal/libpostal

# TODO: chain these commands together once they are working
RUN ./bootstrap.sh 
RUN ./configure --datadir=/datadir 
RUN make 
RUN make install 

### Install python postal ###
RUN pip3 install --upgrade pip && pip3 install postal==1.1.7

# Copy test code to container
COPY test_postal.py /postal_tests

# CMD is overwritten by "entrypoint" in compose file for integration tests
CMD ["./tests/entrypoint"]
