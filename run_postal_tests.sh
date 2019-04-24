#!/bin/sh

# clone python postal repo
apk add git
cd /postal_tests
git clone https://github.com/openvenues/pypostal.git

# build the python library
cd pypostal
python3 setup.py build_ext --inplace
pip3 install nose==1.3.7 six==1.12.0

# run the python library's unit tests
nosetests postal/tests/
