#!/bin/bash

cp -r "$RECIPE_DIR/../" .

mkdir build

cd build

# Create the static libraries
cmake .. \
-DCMAKE_INSTALL_PREFIX=$PREFIX \
-DCMAKE_SHARED_LINKER_FLAGS=-lhdf5 \
-DCGNS_ENABLE_HDF5=YES \
-DCGNS_ENABLE_FORTRAN=NO \
-DCGNS_ENABLE_TESTS=YES \
-DCGNS_BUILD_SHARED=YES \
-DCGNS_USE_SHARED=YES \
-DHDF5_NEED_SZIP=YES \
-DHDF5_NEED_ZLIB=YES \

make -j$CPU_COUNT
ctest --output-on-failure
make install
