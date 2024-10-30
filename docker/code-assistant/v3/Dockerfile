FROM python:3.11.9-slim

RUN apt-get update && apt-get install -y \
    git \
    wget \
    gnupg \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# OpenJDK 17 설치
RUN apt-get update && apt-get install -y openjdk-17-jdk \
    && rm -rf /var/lib/apt/lists/*

RUN git --version
RUN java -version

WORKDIR /app
COPY ./python/requirements-docker.txt .

RUN python -m venv venv

ENV PATH="/app/venv/bin:$PATH"

RUN pip install -r requirements-docker.txt

ENV VIRTUAL_ENV=/app/venv
ENV PYTHONPATH=/app/venv/lib/python3.11/site-packages:$PYTHONPATH
