# Containerfile

FROM ghcr.io/freebsd/freebsd-runtime:14.3

#Update base components and install dependencies
RUN sed -EI -e s/quarterly/latest/ /etc/pkg/FreeBSD.conf
RUN env ASSUME_ALWAYS_YES=yes IGNORE_OS_VERSION=yes pkg bootstrap -r FreeBSD
RUN env ASSUME_ALWAYS_YES=yes IGNORE_OS_VERSION=yes pkg update
RUN env ASSUME_ALWAYS_YES=yes IGNORE_OS_VERSION=yes pkg upgrade -y
RUN env ASSUME_ALWAYS_YES=yes IGNORE_OS_VERSION=yes pkg install -y FreeBSD-utilities openjdk17 zsh

# Download and place the Nexus 3 Application
RUN fetch https://download.sonatype.com/nexus/3/nexus-3.80.0-06-linux-x86_64.tar.gz
RUN tar xvzf nexus-*.tar.gz && rm nexus-*.tar.gz && mv nexus-* /usr/local/nexus

# Cleanup
RUN pkg clean -y

# Place entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

CMD [ "/entrypoint.sh"]