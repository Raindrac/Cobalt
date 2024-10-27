#!/usr/bin/env bash
set -euo pipefail
echo "Preparing to build image..."

# First, retrieve the input from the just command. We'll need it later
cobalt_hardware="$1"
cobalt_branch="$2"
registry="$3"

# Return how the input was parsed for troubleshooting
echo ""
echo "cobalt_hardware: $cobalt_hardware"
echo "cobalt_branch: $cobalt_branch"
echo "registry: $registry"
echo ""

# Next, verify that the user has Podman installed
if ! [[ $(command -v podman) ]]; then
	echo "$(tput bold)$(tput setaf 1)This script requires Podman to run. Please install Podman."
	exit 1
fi

# We also need to verify that a local container registry is online
if ! curl -f ${registry} > /dev/null 2>&1; then
	echo "$(tput bold)$(tput setaf 1)Unable to connect to the provided container registry.$(tput sgr0)"
	exit 1
fi

# Check if input is valid. If not, exit
if ! [[ $cobalt_hardware = "main" || $cobalt_hardware = "nvidia" ]]; then
	echo "$(tput bold)$(tput setaf 1)\"$cobalt_hardware\" isn't a valid hardware variant.$(tput sgr0)"
	echo "Valid Hardware Variants:"
	echo "• main"
	echo "• nvidia"
	exit 1
fi

if ! [[ $cobalt_branch = "latest" || $cobalt_branch = "legacy" || $cobalt_branch = "dev" ]]; then
	echo "$(tput bold)$(tput setaf 1)\"$cobalt_branch\" isn't a valid branch.$(tput sgr0)"
	echo "Valid Branches:"
	echo "• latest"
	echo "• legacy"
	echo "• dev"
	exit 1
fi

# Define some variables for later
declare -A branches=(["latest"]="40" ["dev"]="40" ["legacy"]="39")
fedora_base=${branches[$cobalt_branch]}
image_address="${registry}/cobalt-${cobalt_hardware}:${cobalt_branch}"

# Assemble the Podman command using given inputs, and feed it into a containerfile. Append the tag as well, we need to tag it
command=(podman build -f Containerfile )
command+=( --build-arg="COBALT_HARDWARE=${cobalt_hardware}" )
command+=( --build-arg="FEDORA_BASE=${fedora_base}" )
command+=( --tag ${image_address} )

echo "Running command \"$(tput setaf 2)${command[@]}$(tput sgr0)\""
${command[@]}
podman push ${image_address}

echo ""
echo "Your image is ready to go! Rebase to it now by running the following command:"
echo "\"$(tput setaf 2)rpm-ostree rebase ${image_address}$(tput sgr0)\""
