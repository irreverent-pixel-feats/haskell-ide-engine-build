PWD = $(shell pwd)
REPO = irreverentpixelfeats/ci-haskell-stack
IMAGE_SHA = 20180427081606-f04d0ef
BASE_TAG = ubuntu_xenial

.PHONY: deps build image all

data/version:
	bin/git-version ./latest-version
	diff -q latest-version data/version || cp -v latest-version data/version
	rm latest-version

deps: data/version

build: deps
	docker run -ti --rm -e "GHCVER=${GHCVER}" -e "CABALVER=${CABALVER}" -e "STACKVER=${STACKVER}" -v "/tmp:/tmp/output" -v "$(shell pwd)/bin:/home/bin" "${REPO}:ubuntu_xenial-${GHCVER}_${CABALVER}_${STACKVER}-${IMAGE_SHA}" "/home/bin/build-hie"


images/dev-base-${BASE_TAG}.tar.gz: build
	docker image save -o "images/dev-base-${BASE_TAG}.tar" "${REPO}:${BASE_TAG}"
	cd images && gzip -v "dev-base-${BASE_TAG}.tar"

image: images/dev-base-${BASE_TAG}.tar.gz

all: build image
