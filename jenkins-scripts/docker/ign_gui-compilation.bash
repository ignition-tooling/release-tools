#!/bin/bash -x

# Knowing Script dir beware of symlink
[[ -L ${0} ]] && SCRIPT_DIR=$(readlink ${0}) || SCRIPT_DIR=${0}
SCRIPT_DIR="${SCRIPT_DIR%/*}"

if [[ -z ${ARCH} ]]; then
  echo "ARCH variable not set!"
  exit 1
fi

if [[ -z ${DISTRO} ]]; then
  echo "DISTRO variable not set!"
  exit 1
fi

export BUILDING_SOFTWARE_DIRECTORY="ign-gui"
export BUILDING_PKG_DEPENDENCIES_VAR_NAME="IGN_GUI_DEPENDENCIES"

# Identify IGN_GUI_MAJOR_VERSION to help with dependency resolution
IGN_GUI_MAJOR_VERSION=$(\
  python3 ${SCRIPT_DIR}/../tools/detect_cmake_major_version.py \
  ${WORKSPACE}/ign-gui/CMakeLists.txt)

# Check IGN_GUI_MAJOR_VERSION version is integer
if ! [[ ${IGN_GUI_MAJOR_VERSION} =~ ^-?[0-9]+$ ]]; then
  echo "Error! IGN_GUI_MAJOR_VERSION is not an integer, check the detection"
  exit -1
fi

if [[ ${IGN_GUI_MAJOR_VERSION} -ge 1 ]]; then
  export NEED_C17_COMPILER=true
fi

export GPU_SUPPORT_NEEDED=true
export GZDEV_PROJECT_NAME="ignition-gui${IGN_GUI_MAJOR_VERSION}"

. ${SCRIPT_DIR}/lib/generic-building-base.bash
