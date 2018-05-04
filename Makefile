PWD = $(shell pwd)
REPO = irreverentpixelfeats/ci-haskell-stack
IMAGE_SHA = 20180427081606-f04d0ef
BASE_TAG = ubuntu_xenial

.PHONY: deps build image all publish version

version:
	bin/git-version ./latest-version
	diff -q latest-version data/version || cp -v latest-version data/version
	rm latest-version

deps: version

output/hie: deps bin/build-hie
	docker run -t --rm -e "GHCVER=${GHCVER}" -e "CABALVER=${CABALVER}" -e "STACKVER=${STACKVER}" -v "$(shell pwd)/output:/tmp/output" -v "$(shell pwd)/bin:/home/bin" -v "$(shell pwd)/data:/home/data" "${REPO}:ubuntu_xenial-${GHCVER}_${CABALVER}_${STACKVER}-${IMAGE_SHA}" "/home/bin/build-hie"

build: output/hie

publish: bin/ci.publish bin/publish-hie output/hie
	bin/ci.publish "${GHCVER}" "${CABALVER}" "${STACKVER}" "${REPO}" "${IMAGE_SHA}"

all: build
