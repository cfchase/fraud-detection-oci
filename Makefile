QUAY_USERNAME := $(shell podman login --get-login quay.io)
MODEL_IMAGE_TAG ?= quay.io/${QUAY_USERNAME}/fraud-detection-modelcar:1.0
PROJECT_NAME ?= fraud-detection

build:
	podman build --platform linux/amd64 -t ${MODEL_IMAGE_TAG} -f Dockerfile .

push:
	podman push ${MODEL_IMAGE_TAG}

enable-modelcar:
	scripts/patch-inf-config.sh

deploy:
	oc process -p PROJECT_NAME=${PROJECT_NAME} -p MODEL_IMAGE_TAG=${MODEL_IMAGE_TAG} -f templates/inference-service.yaml | oc apply -f -

undeploy:
	oc process -f templates/inference-service.yaml | oc delete -f -