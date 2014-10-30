# Jenkins will run this build script as part of the application build process.
# Jenkins will provide:
# $WORKSPACE The working directory for the build, usually the same directory that this file is in.
# $BUILD_NUMBER Integer build number
# $BRANCH The git branch that is currently checked out.
# $CANONICAL_VERSION The correct version string for this build. (contents of version file (+ rc) + build number)
# $FEATURE_NAME A cleaned-up feature name, ff this is a feature branch.
#
# The 'version' file at the root of the repo will be prepoulated with #CANONICAL_VERSION
#
# ******** RESPONSIBILITIES OF THIS BUILD SCRIPT *********
# This build scipt must generate the following output:
# - A directory called ./build_output/ containing a single file called 'build-$BUILD_NUMBER.tgz'
# This tarball will be the application that is deployed to a server.
# Paths within the tarball should not be prefixed with the build directory; the tarball
# will be extracted into the working directory of the application on the server.
# - The `version` file at the root of this repo shall contain the $CANONICAL_VERSION. We leave this 
# responsibility to the build script, because you may want to perform git actions (such as checking in 
# a new Gemfile.lock after bundle updating) without tainting the commited version file.
# - If this app is also a gem, we want the Gemfile.lock to have the correct version number for self, so you should
#    bundle update <THIS_GEM> --source <THIS_GEM>
# after you echo the $CANONICAL_VERSION to the `version` file.

set -e
#set -x

bundle check || bundle install
bundle update

if ! git diff --quiet $WORKSPACE/Gemfile.lock
then
  # testfile has changed
  git add testfile
  git commit -m '[jenkins] bundle update and commit Gemfile.lock'
fi

#git status

#bundle check || bundle install
#bundle install --gemfile $WORKSPACE/Gemfile --deployment --without development test
#bundle clean

echo $CANONICAL_VERSION > $WORKSPACE/version

rm -rfv $WORKSPACE/build_output
mkdir -pv $WORKSPACE/build_output
echo "foo" > $WORKSPACE/build_output/build-${BUILD_NUMBER}.tgz

#tar  -C $WORKSPACE \
#    --exclude='./pkg' \
#    --exclude='./build_output' \
#    --exclude='./.git' \
#    --exclude='./.cibuild.sh' \
#    --exclude='./config/config.yml' \
#    -zcf $WORKSPACE/build_output/build-${BUILD_NUMBER}.tgz .
