#!/usr/bin/env bash
set -euo pipefail

echo ${1}
echo ""
echo "Build complete! Pushing image to your registry..."
echo ""
podman push ${1}

echo ""
echo "Your image is ready to go! Rebase to it now by running the following command:"
echo "\"$(tput setaf 2)rpm-ostree rebase ${1}$(tput sgr0)\""
