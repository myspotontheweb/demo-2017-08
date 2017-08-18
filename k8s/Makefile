.PHONY: build deploy clean
REGISTRY=$(shell docker-machine ip k8s-registry):5000

build:
	docker image build -t k8s-demo:v1 .
	docker tag k8s-demo:v1 $(REGISTRY)/k8s-demo:v1
	docker push $(REGISTRY)/k8s-demo:v1

deploy:
	kubectl run demo --image=$(REGISTRY)/k8s-demo:v1 --replicas 3 --port 80
	kubectl expose deployment demo --type LoadBalancer

clean:
	kubectl delete service demo
	kubectl delete deployment demo
