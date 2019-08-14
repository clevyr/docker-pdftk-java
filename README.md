# docker-pdftk-java

[![](https://images.microbadger.com/badges/image/clevyr/pdftk-java.svg)](https://microbadger.com/images/clevyr/pdftk-java "Get your own image badge on microbadger.com")

Docker alpine image with [pdftk-java](https://gitlab.com/pdftk-java/pdftk) build and `openjdk8-jre` installed.

## Usage

A shell script called `pdftk` has been created to defer calls off to the built binary `/app/pdftk.jar`

Example Usage:

```sh
docker run --rm clevyr/pdftk-java pdftk --help
```

If you need the executable in another Docker container, make sure you have installed `openjdk8-jre` (Or your distro-equivalent), then run this on build:

```sh
COPY --from=clevyr/pdftk-java /app/ /usr/local/bin/
```
