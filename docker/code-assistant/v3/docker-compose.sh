ENV_FILE_PATH=./env/.plateer.env \
CONTAINER_NAME=code-assistant-python-plateer \
docker compose -f code-assistant-compose.yaml up -d --build
