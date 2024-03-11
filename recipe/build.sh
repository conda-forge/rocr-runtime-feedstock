#!/bin/bash


cd src
mkdir build
cd build

export HIP_DEVICE_LIB_PATH=$PREFIX/lib/amdgcn/bitcode

cmake ${CMAKE_ARGS} \
  -DCMAKE_INSTALL_PREFIX=$PREFIX \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_INSTALL_LIBDIR=lib \
  -DBUILD_SHARED_LIBS=ON \
  ..

make VERBOSE=1 -j${CPU_COUNT}
make install

rm -rf $PREFIX/lib/libhsa-runtime*
mv $PREFIX/hsa/lib/libhsa-runtime* $PREFIX/lib/
ln -sf $PREFIX/lib/libhsa-runtime* $PREFIX/hsa/lib
