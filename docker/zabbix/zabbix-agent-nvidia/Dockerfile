# ./Dockerfile
FROM zabbix/zabbix-agent2:7.2-ubuntu-latest

USER root

RUN apt-get update && apt-get install -y wget bash build-essential golang-go

RUN mkdir -p /usr/sbin/zabbix-agent2-plugin
COPY ./nvidia-gpu /nvidia-gpu

WORKDIR /nvidia-gpu
RUN CGO_ENABLED=1 go build -o nvidia-plugin .

COPY ./nvidia.conf /etc/zabbix/zabbix_agent2.d/plugins.d/nvidia.conf

RUN mkdir -p /usr/lib/zabbix/agent2/plugins \
    && cp ./nvidia-plugin /usr/lib/zabbix/agent2/plugins/zabbix_agent2_plugin_nvidia \
    && chmod +x /usr/lib/zabbix/agent2/plugins/zabbix_agent2_plugin_nvidia

USER zabbix