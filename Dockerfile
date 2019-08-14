FROM alpine

WORKDIR /app

ENV PATH "$PATH:/app"

ARG OPENJDK_RELEASE=8
ARG PDFTK_RELEASE=v3.0.6

RUN set -x \
    && apk add \
        "openjdk$OPENJDK_RELEASE-jre" \
    && apk add --virtual .build-deps \
        git \
        gradle \
        "openjdk$OPENJDK_RELEASE" \
    && git clone -q \
        --config advice.detachedHead=false \
        --branch "$PDFTK_RELEASE" \
        --depth 1 \
         https://gitlab.com/pdftk-java/pdftk \
    && gradle --no-daemon --parallel --quiet --no-build-cache \
        -p pdftk shadowJar \
    && mv pdftk/build/libs/pdftk.jar ./ \
    && rm -rf \
        /root/.gradle \
        pdftk \
    && apk del .build-deps

COPY rootfs/ /

CMD ["pdftk"]
