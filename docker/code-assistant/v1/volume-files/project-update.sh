cd /home

USERNAME=$GIT_USERNAME
PASSWORD=$GIT_PASSWORD

TARGET_DIR="codechatbotforx2beedemo"
REPO_URL="https://$USERNAME:$PASSWORD@gitlab.x2bee.com/tech-team-gpt/codechatbotforx2beedemo.git"

# 디렉토리가 존재하는지 확인
if [ -d "$TARGET_DIR" ]; then
  cd $TARGET_DIR

  pip install -r requirements.txt
  # 디렉토리가 Git 리포지토리인지 확인
  if [ -d ".git" ]; then
    git reset --hard HEAD
    git fetch origin
    git reset --hard origin/master
    #git pull
  else
    echo "Error: $TARGET_DIR is not a git repository."
    exit 1
  fi
else
  echo "Error: $TARGET_DIR does not exist."
  exit 1
fi

cd /home/$TARGET_DIR

if [ -n "$PY_SCRIPT" ]; then
    echo "python run"
    python $PY_SCRIPT
fi

streamlit run app.py
