#chmod +x install_git.sh
#!/bin/sh
# 패키지 목록 업데이트
apt-get update

# Git 설치
apt-get install -y git

# Git 설치 확인
git --version

cd /home

USERNAME=$GIT_USERNAME
PASSWORD=$GIT_PASSWORD

# 이미 디렉토리가 존재하면 삭제
#if [ -d "codechatbotforx2beedemo" ]; then
#  rm -rf codechatbotforx2beedemo
#fi

git clone https://$USERNAME:$PASSWORD@gitlab.x2bee.com/tech-team-gpt/codechatbotforx2beedemo.git
