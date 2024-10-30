#!/usr/bin/env bash
# 🛠 Build Step 3: Run "./Build Scripts/Manage Packages.sh"
#   🠈 Previous Step: Run podman build on "./Containerfile"
#   🠊 Next Step: Resume running "./Build Scripts/Start Image Build.sh"
set -euo pipefail
export TERM=xterm-256color

packages_added=($(jq -r "."All"."Added" + .\"$FEDORA_BASE\"."Added" | unique[]" "/Build Files/Package List.json"))
packages_removed=($(jq -r "."All"."Removed" + .\"$FEDORA_BASE\"."Removed" | unique[]" "/Build Files/Package List.json"))

if [ ${#packages_added[*]} -gt 0 ]; then
	echo ""
	echo "$(tput bold)Adding the following packages:$(tput sgr0)"
	echo "${packages_added[*]}"
	echo ""
	rpm-ostree install -y ${packages_added[*]}
fi

if [ ${#packages_removed[*]} -gt 0 ]; then
	echo ""
	echo "$(tput bold)Removing the following packages:$(tput sgr0)"
	echo "${packages_removed[*]}"
	echo ""
	rpm-ostree uninstall -y ${packages_removed[*]}
fi

# 🛠 🠊 Go back to "./Build Scripts/Start Image Build.sh"