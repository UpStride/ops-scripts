#!/usr/bin/env bash
# Test scripts are no making any harm for a dry run
# generic error
function error() {
  echo "x failed" && exit 2;
}

# browse 'docker' public repos and check if at least 'docker-ce|cli|compose|engine' are there
echo "#0 'browse-github' of docker"
GITHUB_TOKEN=xxx GITHUB_USERNAME=xxx bash browse-github/run -o docker 2>/dev/null | \
 grep -E "repos ([1-9][0-9][0-9])" >/dev/null || error
echo "#alright!"
