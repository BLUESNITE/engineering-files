TAG=$(date +"%m%d%H%M%S")
docker build -t code-assistant-python-3.11.9-slim:1.${TAG} .
docker image tag code-assistant-python-3.11.9-slim:1.${TAG} docker-dev.x2bee.com/ai-labs/code-assistant-python-3.11.9-slim:1.${TAG}
#docker push docker-dev.x2bee.com/ai-labs/code-assistant-python-3.11.9-slim:1.${TAG}
docker rmi -f code-assistant-python-3.11.9-slim:1.${TAG} .
#docker rmi -f docker-dev.x2bee.com/ai-labs/code-assistant-python-3.11.9-slim:1.${TAG}
