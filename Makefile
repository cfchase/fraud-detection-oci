MODEL_IMAGE_TAG ?= quay.io/cfchase/fraud-detection-modelcar:v1.0

build:
	podman build --platform linux/amd64 -t ${MODEL_IMAGE_TAG} -f Dockerfile .

push:
	podman push ${MODEL_IMAGE_TAG}

enable-modelcar:
	./scripts/patch-inf-config.sh

deploy:
	oc process -p MODEL_IMAGE_TAG=${MODEL_IMAGE_TAG} -f templates/inference-service.yaml | oc apply -f -

undeploy:
	oc process -p MODEL_IMAGE_TAG=${MODEL_IMAGE_TAG} -f templates/inference-service.yaml | oc delete -f -