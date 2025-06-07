default: all

all: buildah

buildah:
	#podman build --no-hosts --squash -t 'cloudbsd/nexus3:14.3' -f ./Containerfile
	podman build -t 'cloudbsd/nexus3:14.3' -f ./Containerfile

clean:
	podman image prune -af
