cd /home/${CONTAINER_NAME}

PID=$(pgrep -f "python $PYTHON_FLASK")

if [ ! -z "$PID" ]; then
    echo "Killing process with PID: $PID"
    sudo kill -9 $PID
    echo "Process killed"
else
    echo "No matching process found"
fi

echo "$PYTHON_INFO_MAKEER 실행 전 5초 Sleep"

sleep 5  # 5초 딜레이

python3.11 $PYTHON_INFO_MAKEER

echo "$PYTHON_FLASK 재실행 전 5초 Sleep"

python3.11 $PYTHON_FLASK
