# Create registry
docker-machine create k8s-registry
docker-machine ssh k8s-registry docker run -d -p 5000:5000 --restart=always --name registry -v /home/docker/data:/var/lib/registry registry:2

# Create local k8s cluster
minikube start --cpus=2 --memory=4096 --insecure-registry=$(docker-machine ip k8s-registry):5000
minikube addons enable ingress

