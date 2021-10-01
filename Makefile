VERSION=$(shell cat VERSION)
REF=$(shell git rev-parse --short HEAD)
CREATED=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ')

all:
	$(MAKE) build
	$(MAKE) tag
	$(MAKE) push

push:
	docker push savonarola/emqx-relup-env:$(VERSION)

build:
	docker build \
		--build-arg VERSION="$(VERSION)" \
		--build-arg REF="$(REF)" \
		--build-arg CREATED="$(CREATED)" \
		-t emqx-relup-env:$(VERSION) .

tag:
	docker tag emqx-relup-env:$(VERSION) savonarola/emqx-relup-env:$(VERSION)
