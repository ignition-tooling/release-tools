echo '# BEGIN SECTION: setup the testing enviroment'
DOCKER_JOB_NAME="drake_standalone"
. ${SCRIPT_DIR}/lib/boilerplate_prepare.sh
echo '# END SECTION'

cat > build.sh << DELIM
###################################################
#
set -ex

echo '# Install docker (in docker)'
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update
apt-get install -y docker-ce
echo '# END SECTION'

echo '# Download drake-release repo'
[[ -d ${WORKSPACE}/drake-release-tools ]] && rm -fr ${WORKSPACE}/drake-release-tools
git clone https://github.com/j-rivero/drake-release-tools ${WORKSPACE}/drake-release-tools
echo '# END SECTION'

echo '# BEGIN SECTION: run release new snapshot'
cd ${WORKSPACE}/drake-release-tools
/bin/bash -e build-drake-pkg.bash
echo '# END SECTION'
DELIM


USE_GPU_DOCKER=true # workaround for getting privileged
OSRF_REPOS_TO_USE="drake"
DEPENDENCY_PKGS="sudo \
		 bash \
		 git \
                 apt-transport-https \
                 ca-certificates \
                 curl \
                 software-properties-common"

. ${SCRIPT_DIR}/lib/docker_generate_dockerfile.bash
. ${SCRIPT_DIR}/lib/docker_run.bash
