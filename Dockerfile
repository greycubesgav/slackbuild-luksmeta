ARG DOCKER_FULL_BASE_IMAGE_NAME=greycubesgav/slackware-docker-base:aclemons-current
FROM ${DOCKER_FULL_BASE_IMAGE_NAME} AS builder

ARG TAG='_SL-CUR_GG' VERSION=9 BUILD=1

# Copy over the build files
COPY src/luksmeta/luksmeta-${VERSION}.tar.bz2 LICENSE src/luksmeta/luksmeta.info src/luksmeta/luksmeta.SlackBuild src/luksmeta/README src/luksmeta/slack-desc /root/build/
WORKDIR /root/build/
# Update the luksmeta.info file to match the version we're building
RUN sed -i "s|VERSION=.*|VERSION=\"${VERSION}\"|" luksmeta.info && export MD5SUM=$(md5sum luksmeta-${VERSION}.tar.xz | cut -d ' ' -f 1) && sed -i "s|_MD5SUM_|${MD5SUM}|" luksmeta.info
# Build the package
RUN VERSION="$VERSION" TAG="$TAG" BUILD="$BUILD" ./luksmeta.SlackBuild
RUN installpkg /tmp/luksmeta-${VERSION}*.tgz

# #ENTRYPOINT [ "bash" ]

# Create a clean image with only the artifact
FROM scratch AS artifact
COPY --from=builder /tmp/luksmeta-*.tgz .