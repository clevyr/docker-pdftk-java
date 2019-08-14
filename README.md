# docker-pdftk-java

Docker alpine image with [pdftk-java](https://gitlab.com/pdftk-java/pdftk) build and `opnjdk8` installed.

## Usage

A shell script called `pdftk` has been created to defer calls off to the built binary `/app/pdftk.jar`

```sh
docker run --rm clevyr/pdftk-java pdftk --help
```
