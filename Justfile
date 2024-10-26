## Cobalt Build Process Step 1: Just Command
# Build Image
build-image cobalt_hardware="" cobalt_branch="" registry="":
    @./scripts/build/build-image.sh {{ cobalt_hardware }} {{ cobalt_branch }} {{ registry }}
