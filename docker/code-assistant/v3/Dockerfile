FROM python:3.11.9-slim

RUN apt-get update
RUN apt-get install -y git
RUN git --version

WORKDIR /app
COPY requirements-docker.txt .

RUN python -m venv venv
RUN pip install -r requirements-docker.txt
