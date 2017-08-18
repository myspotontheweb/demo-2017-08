.PHONY: build deploy
REGISTRY=$(shell docker-machine ip swarm-registry):5000

build:
	docker image build -t swarm-demo:v1 .
	docker tag swarm-demo:v1 $(REGISTRY)/swarm-demo:v1
	docker push $(REGISTRY)/swarm-demo:v1

deploy:
	docker service create -d --replicas 3 -p 80 --name demo  $(REGISTRY)/swarm-demo:v1

