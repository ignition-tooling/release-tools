# Identify GAZEBO_MAJOR_VERSION to help with dependency resolution
if [ "${GAZEBO_EXPERIMENTAL_BUILD}" = true ]; then
  # Identify GAZEBO_MAJOR_VERSION to help with dependency resolution
  GAZEBO_MAJOR_VERSION=0
else
  GAZEBO_MAJOR_VERSION=`\
    grep 'set.*GAZEBO_MAJOR_VERSION ' ${WORKSPACE}/gazebo/CMakeLists.txt | \
    tr -d 'a-zA-Z _()'`
fi

# Check gazebo version is integer
if ! [[ ${GAZEBO_MAJOR_VERSION} =~ ^-?[0-9]+$ ]]; then
  echo "Error! GAZEBO_MAJOR_VERSION is not an integer, check the detection"
  exit -1
fi
