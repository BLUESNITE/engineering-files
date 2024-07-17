#!/bin/sh

echo "Starting node.sh script"

echo "ENV_SECRET_FILE: ${ENV_SECRET_FILE}"
echo "ENV_SLAVE_NAME: ${ENV_SLAVE_NAME}"
echo "ENV_HOST_SEVER: ${ENV_HOST_SEVER}"

# curl 설치 여부 확인 및 설치
if ! command -v curl &> /dev/null; then
  apt-get update -y && apt-get install curl -y
fi

# secret 파일 생성
echo ${ENV_SECRET_FILE} > /var/jenkins_home/secret-file

# agent.jar 다운로드
curl -sO http://${ENV_HOST_SEVER}/jnlpJars/agent.jar
chown -R /home/jenkins/agent.jar
chmod -R 755 /home/jenkins/agent.jar

echo "down end agent"

# Jenkins 홈 디렉토리 권한 설정
chown -R jenkins:jenkins /var/jenkins_home
chmod -R 755 /var/jenkins_home

# Jenkins 에이전트 실행
# ENV_SLAVE_NAME
java -jar /home/jenkins/agent.jar -url http://${ENV_HOST_SEVER}/ -secret @/var/jenkins_home/secret-file -name "${ENV_SLAVE_NAME}" -workDir /var/jenkins_home

# SSH 데몬 설정
echo "Finished node.sh script"
