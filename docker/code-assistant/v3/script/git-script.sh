#!/bin/sh
cd /home

USERNAME=$GIT_USERNAME
PASSWORD=$GIT_PASSWORD
URL=$GIT_URL

# 폴더가 이미 존재하는지 확인
if [ -d "$CONTAINER_NAME/.git" ]; then
  echo "$CONTAINER_NAME 폴더가 이미 존재합니다. 업데이트를 위해 git pull을 실행합니다."
  cd $CONTAINER_NAME
  git pull
else
  echo "$PROJECT_NAME 폴더가 존재하지 않습니다. 새로 클론합니다."
  git clone -b $GIT_BRANCH https://$USERNAME:$PASSWORD@$URL $CONTAINER_NAME
fi
echo "$PROJECT_NAME 깃 동작을 완료하였습니다."