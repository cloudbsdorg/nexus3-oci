# Containerfile
# podman build --no-hosts --squash -t cloudbsd/nexus3:14.3 -f ./Containerfile


FROM ghcr.io/freebsd/freebsd-runtime:14.3
RUN sed -EI -e s/quarterly/latest/ /etc/pkg/FreeBSD.conf
RUN env ASSUME_ALWAYS_YES=yes IGNORE_OS_VERSION=yes pkg bootstrap -r FreeBSD
RUN pkg update
RUN pkg install -y FreeBSD-openssl openjdk17
RUN pkg upgrade -y
RUN pkg clean -y
