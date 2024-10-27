ARG COBALT_HARDWARE="main"
ARG FEDORA_BASE="40"

FROM scratch AS buildscripts
COPY ["/Build Scripts", "/"]
FROM ghcr.io/ublue-os/silverblue-${COBALT_HARDWARE}:${FEDORA_BASE}

RUN --mount=type=bind,from=buildscripts,source="/",target="/Build Scripts" \
	mkdir -p /var/lib/alternatives && \
	"/Build Scripts/Manage Packages.sh" && \
	ostree container commit
