#!/usr/bin/env bash
# load utility functions
source "$(dirname "$0")/utils.sh"

# check 'docker' has at least 100 public repos on github
echo "#0 'browse-github' of docker"
browse-github/run -o docker 2>/dev/null | grep -E "repos ([1-9][0-9][0-9])" >/dev/null || error
echo "#alright!"
