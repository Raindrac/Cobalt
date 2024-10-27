#!/usr/bin/env bash
set -euo pipefail

packages_added=($(jq -r "."All"."Added" + .\"$FEDORA_BASE\"."Added" | unique[]" "/Build Files/Package List.json"))
packages_removed=($(jq -r "."All"."Removed" + .\"$FEDORA_BASE\"."Removed" | unique[]" "/Build Files/Package List.json"))

if [ ${#packages_added[*]} -gt 0 ]; then
	echo ""
	echo "Adding the following packages:"
	echo "${packages_added[*]}"
	echo ""
	rpm-ostree install -y ${packages_added[*]}
fi

if [ ${#packages_removed[*]} -gt 0 ]; then
	echo ""
	echo "Removing the following packages:"
	echo "${packages_removed[*]}"
	echo ""
	rpm-ostree uninstall -y ${packages_removed[*]}
fi
