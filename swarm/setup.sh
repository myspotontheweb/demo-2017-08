# Create registry
docker-machine create swarm-registry
docker-machine ssh swarm-registry docker run -d -p 5000:5000 --restart=always --name registry -v /home/docker/data:/var/lib/registry registry:2

# Create machines
REGISTRY=$(docker-machine ip swarm-registry):5000

docker-machine create --engine-insecure-registry $REGISTRY swarm-manager1
docker-machine create --engine-insecure-registry $REGISTRY swarm-worker1
docker-machine create --engine-insecure-registry $REGISTRY swarm-worker2

# Init swarm
MANAGER_IP=$(docker-machine ip swarm-manager1)

docker-machine ssh swarm-manager1 docker swarm init --advertise-addr $MANAGER_IP --force-new-cluster

# Add workers
TOKEN=$(docker-machine ssh swarm-manager1 docker swarm join-token worker -q)

docker-machine ssh swarm-worker1 docker swarm join --token $TOKEN $MANAGER_IP:2377
docker-machine ssh swarm-worker2 docker swarm join --token $TOKEN $MANAGER_IP:2377

# Configure docker client
eval $(docker-machine env swarm-manager1)
docker node ls

