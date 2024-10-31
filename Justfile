# 🛠 Build Image
build-image cobalt_hardware="" cobalt_branch="" registry="":
	@"./Build Scripts/Start Image Build.sh" {{ cobalt_hardware }} {{ cobalt_branch }} {{ registry }}
# 🛠 🠊 Go to "./Build Scripts/Start Image Build.sh"