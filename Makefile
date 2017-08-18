ifeq ($(DOCKER_ARCH),armhf)
	DOCKER_IMAGE_NAME := tenstartups/alarmdecoder-webapp:armhf
else
	DOCKER_ARCH := x64
	DOCKER_IMAGE_NAME := tenstartups/alarmdecoder-webapp:latest
endif

build: Dockerfile.$(DOCKER_ARCH)
	docker build --file Dockerfile.$(DOCKER_ARCH) --tag $(DOCKER_IMAGE_NAME) .

clean_build: Dockerfile.$(DOCKER_ARCH)
	docker build --no-cache --pull --file Dockerfile.$(DOCKER_ARCH) --tag $(DOCKER_IMAGE_NAME) .

run: build
	docker run -it --rm \
	-p 5000:5000 \
	-v /etc/localtime:/etc/localtime \
	-e VIRTUAL_HOST=alarm-decoder.docker \
	--name alarm-decoder \
	$(DOCKER_IMAGE_NAME) $(ARGS)

push: build
	docker push $(DOCKER_IMAGE_NAME)
