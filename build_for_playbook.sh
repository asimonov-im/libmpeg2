#!/bin/bash 

# Copyright (c) 2011 Research In Motion Limited.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

# http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# This script builds the SDL library.  It is useful as 
# an example of how to build software for the playbook 
# platform where the build system for that software is 
# configured with autoconf tools. 


#We set a destination where everything gets installed.

PREFIX=$(pwd)/../install

RANLIB="${QNX_HOST}/usr/bin/ntoarmv7-ranlib " \
CPP="${QNX_HOST}/usr/bin/qcc -V4.4.2,gcc_ntoarmv7le_gpp -E " \
CC="${QNX_HOST}/usr/bin/qcc -V4.4.2,gcc_ntoarmv7le_gpp " \
LD="${QNX_HOST}/usr/bin/ntoarmv7-ld " \
CPPFLAGS="-D__PLAYBOOK__ -D__QNXNTO__ " \
CFLAGS=" -g " \
LDFLAGS="-L${QNX_TARGET}/armle-v7/lib -L${PREFIX}/lib" \
PKG_CONFIG_PATH=${PREFIX}/lib/pkgconfig \
PKG_CONFIG_LIBDIR=${PREFIX}/lib/pkgconfig \
./configure --prefix="${PREFIX}" \
            --build=i686-pc-linux \
            --host=arm-unknown-nto-qnx6.5.0eabi

PREFIX=${PREFIX} make all


if [ $? != 0 ]; then
  echo "Build Failed!"
  exit 1
fi

PREFIX=${PREFIX} make install

echo "Build Successful!!"
exit 0
