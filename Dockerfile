FROM totalvoidness/ppatools:latest

ENV CRYPTOMATOR_VERSION 1.0.3b
ENV CRYPTOMATOR_FULL_VERSION 1.0.3b-0~ppa1
ENV GPG_PASSPHRASE toBeSpecifiedWhenRunningThisContainer

# import gpg key
COPY A8240A09.asc /tmp/
RUN gpg --import /tmp/A8240A09.asc

# initialize build directory
RUN curl -o /home/cryptomator_${CRYPTOMATOR_VERSION}.orig.tar.gz -L https://github.com/cryptomator/cryptomator/releases/download/${CRYPTOMATOR_VERSION}/cryptomator_${CRYPTOMATOR_VERSION}.tar.gz
RUN tar -xzf /home/cryptomator_${CRYPTOMATOR_VERSION}.orig.tar.gz -C /home/
COPY build.sh /home/
COPY debian /home/cryptomator_${CRYPTOMATOR_VERSION}/debian/

# create debian source package
CMD /bin/sh /home/build.sh

# expose result directory
VOLUME /home/dist
