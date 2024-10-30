#!/usr/bin/env bash
# 🛠 Build Step 5: "./Build Scripts/End Image Build.sh"
#   🠈 Previous Step: Resume running "./Build Scripts/Start Image Build.sh"
set -euo pipefail

echo ${1}
echo ""
echo "Build complete!"
echo "$(tput bold)Pushing the image to your registry...$(tput sgr0)"
echo ""
podman push ${1}

echo ""
echo "$(tput bold)Your image is ready to go! Rebase to it now by running the following command:$(tput sgr0)"
echo "\"$(tput bold)$(tput setaf 2)rpm-ostree rebase ${1}$(tput sgr0)\""
