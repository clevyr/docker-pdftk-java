FROM alpine:3.15

WORKDIR /app

ENV PATH="$PATH:/app"

ARG OPENJDK_RELEASE=25
ARG PDFTK_RELEASE=v3.3.3

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
    && mv pdftk/build/libs/pdftk-all.jar ./pdftk.jar \
    && apk del .build-deps \
    && rm -rf \
        /root/.gradle \
        pdftk \
        /var/cache/apk/*

COPY rootfs/ /

CMD ["pdftk"]
