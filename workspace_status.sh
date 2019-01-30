#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

#`p_` takes two arguments to define a bazel workspace status variable:
#
#  * the name of the variable
#  * a default value
#
# If an environment variable with the corresponding name is set, its value is
# used. Otherwise, the provided default value is used.
p_() {
    if (( $# == 2 )); then
        echo "$1" "${!1:-$2}"
    else
        return 1
    fi
}

git_branch="$(git rev-parse --abbrev-ref HEAD)"
git_desc="$(git describe --always)"
img_name="cip"

p_ IMG_REGISTRY gcr.io
p_ IMG_REPOSITORY cip-demo-staging/"${img_name}"
p_ IMG_NAME "${img_name}"
p_ IMG_TAG "${git_branch}-${git_desc}"
p_ GIT_BRANCH "${git_branch}"
p_ GIT_DESC "${git_desc}"