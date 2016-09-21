
#!/bin/bash

mkdir build
cd build

#export LDFLAGS="-L${PREFIX}/lib $LDFLAGS"

if [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  DYNAMIC_EXT="so"
fi
if [ "$(uname -s)" == "Darwin" ]; then
  DYNAMIC_EXT="dylib"
fi

if [ $PY3K -eq 1 ]; then
  export PY_STR="${PY_VER}m"
else
  export PY_STR="${PY_VER}"
fi


#if [ `uname` == Linux ]; then
    PY_LIB="libpython${PY_STR}.$DYNAMIC_EXT"

    include_path=${PREFIX}/include/python${PY_STR}
    library_file_path=${PREFIX}/lib/${PY_LIB}


    cmake -LAH .. \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${PREFIX}" \
        -DINSTALL_BIN_DIR="${PREFIX}/bin" \
        -DINSTALL_INC_DIR="${PREFIX}/include" \
        -DINSTALL_LIB_DIR="${PREFIX}/lib" \
        -DCMAKE_INSTALL_RPATH:STRING="${PREFIX}/lib" \
        -DINSTALL_PKGCONFIG_DIR="${PREFIX}/lib/pkgconfig" \
        -DBUILD_DOCUMENTATION=OFF \
        -DVTK_HAS_FEENABLEEXCEPT=OFF \
        -DBUILD_TESTING=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_SHARED_LIBS=ON \
        -DVTK_WRAP_PYTHON=ON \
        -DPYTHON_EXECUTABLE=${PYTHON} \
        -DPYTHON_INCLUDE_PATH:PATH=${include_path} \
        -DPYTHON_LIBRARY:FILEPATH=${library_file_path} \
        -DVTK_INSTALL_PYTHON_MODULE_DIR=${SP_DIR} \
        -DModule_vtkRenderingMatplotlib=ON \
        -DVTK_USE_X=OFF
#fi

make -j${CPU_COUNT}
make install
