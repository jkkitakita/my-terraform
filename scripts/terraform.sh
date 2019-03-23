#!/bin/sh

target_dir=${1}

current_branch=`git rev-parse --abbrev-ref @`
echo current_branch: $current_branch

if [ $current_branch = "master" ]; then
  target="HEAD^ HEAD"
else
  target="origin/master"
fi

echo target: $target

changed_dirs=$(git diff --name-only $target $target_dir | xargs -IXXX dirname XXX | grep -v -e '^terraform$' -e 'terraform/modules' -e 'terraform/scripts' | uniq )

echo changed_dirs: $changed_dirs
for changed_dir in $changed_dirs; do
  echo changed_dir: $changed_dir
  cd $changed_dir
  ENV=${ENV} make ${2} GCP_BACKEND_CREDENTIALS="${GOOGLE_BACKEND_CREDENTIALS}" GCP_CREDENTIALS="${GOOGLE_APPLICATION_CREDENTIALS}"
  cd -
done
