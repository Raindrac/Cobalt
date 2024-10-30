# 🛠 Build Step 2: Run podman build on "./Containerfile"
#   🠈 Previous Step: Run the beginning of "./Build Scripts/Start Image Build.sh"
#   🠊 Next Step: Run "./Build Scripts/Manage Packages.sh"
ARG COBALT_HARDWARE="main"
ARG FEDORA_BASE="40"

FROM scratch AS buildscripts
COPY ["/Build Scripts", "/Build Scripts"]
COPY ["/Build Files", "/Build Files"]
FROM ghcr.io/ublue-os/silverblue-${COBALT_HARDWARE}:${FEDORA_BASE}

ARG COBALT_HARDWARE="main"
ARG FEDORA_BASE="40"

RUN --mount=type=bind,from=buildscripts,source="/Build Scripts",target="/Build Scripts" \
	--mount=type=bind,from=buildscripts,source="/Build Files",target="/Build Files" \
	mkdir -p /var/lib/alternatives && \
	"/Build Scripts/Manage Packages.sh" && \ # 🛠 🠊 Go to "./Build Scripts/Manage Packages.sh"
	ostree container commit
