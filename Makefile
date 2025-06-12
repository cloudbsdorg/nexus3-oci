IMG_ORG?=cloudbsd
IMG_NAME?=nexus3
IMG_VERSION?=FreeBSD-14.3-3.80.0-06
IMG_TAG?=$(IMG_ORG)/$(IMG_NAME):$(IMG_VERSION)
DNS_SERVER?=8.8.8.8

default: all

all: buildah publish

buildah:
	podman build  -t '$(IMG_TAG)' -f ./Containerfile --dns=$(DNS_SERVER)
	podman build  -t 'docker.io/$(IMG_TAG)' -f ./Containerfile --dns=$(DNS_SERVER)

clean:
	podman image prune -af

run:
	podman run -it -p 8081:8081 localhost/$(IMG_TAG)

console:
	podman run  -it localhost/$(IMG_TAG) /bin/sh

compose:
	podman-compose up

publish:
	podman push docker.io/$(IMG_TAG)

latest:
	podman build  -t '$(IMG_ORG)/$(IMG_NAME):latest' -f ./Containerfile --dns=$(DNS_SERVER)
	podman build  -t 'docker.io/$(IMG_ORG)/$(IMG_NAME):latest' -f ./Containerfile --dns=$(DNS_SERVER)
	podman push docker.io/cloudbsd/nexus3:latest

snap:
	make -f Makefile.15

# podman exec -it nexus3-oci_nexus_1  cat /usr/local/sonatype-work/nexus3/admin.password