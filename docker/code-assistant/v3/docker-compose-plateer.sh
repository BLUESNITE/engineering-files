ENV_FILE_PATH=./env/.plateer.env \
CONTAINER_NAME=code-assistant-python-plateer \
HOST_PORT=8501 \
CONTAINER_PORT=8501 \
docker compose -f code-assistant-compose.yaml up -d --build
