## Cobalt Build Process Step 1: Just Command
# Build Image
build-image cobalt_hardware="" cobalt_branch="" registry="":
    @./scripts/build/start-image-build.sh {{ cobalt_hardware }} {{ cobalt_branch }} {{ registry }}
