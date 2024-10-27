## Cobalt Build Process Step 1: Just Command
# Build Image
build-image cobalt_hardware="" cobalt_branch="" registry="":
    @"./Build Scripts/Start Image Build.sh" {{ cobalt_hardware }} {{ cobalt_branch }} {{ registry }}
