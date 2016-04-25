#!/bin/bash

# export CFLAGS="-m64 -pipe -O2 -march=x86-64"
# export CXXFLAGS="${CFLAGS}"

#$PYTHON configure.py
#$PYTHON setup.py build
#make -j$CPU_COUNT
#$PYTHON setup.py install


export CFLAGS="-m64 -pipe -O2 -march=x86-64"
export CXXFLAGS="${CFLAGS}"

$PYTHON configure.py --cuda-inc-dir=/usr/local/cuda/include --cuda-root=/usr/local/cuda
echo "---------------------------------------"
cat ./siteconf.py;
echo "---------------------------------------"
make -j$CPU_COUNT
#$PYTHON setup.py build
$PYTHON setup.py install
