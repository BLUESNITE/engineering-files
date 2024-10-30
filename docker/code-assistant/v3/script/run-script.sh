cd /home/${CONTAINER_NAME}

cp requirements.txt /app/

cd /app/

/app/venv/bin/pip install -r requirements.txt

cd /home/${CONTAINER_NAME}

python $PYTHON_SCRIPT

echo "end run-script.sh"
