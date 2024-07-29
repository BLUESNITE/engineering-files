cd /home/codechatbotforx2beedemo

python -m venv venv

pip install -r requirements.txt

if [ -n "$MAIN_SCRIPT" ]; then
    python $MAIN_SCRIPT
fi

streamlit run app.py
