ARG COBALT_HARDWARE="main"
ARG FEDORA_BASE="40"

FROM scratch AS buildscripts
COPY /scripts/build /
FROM ghcr.io/ublue-os/silverblue-${COBALT_HARDWARE}:${FEDORA_BASE}

RUN --mount=type=bind,from=buildscripts,source=/,target=/buildscripts \
	mkdir -p /var/lib/alternatives && \
	/buildscripts/build-instructions.sh && \
	ostree container commit
