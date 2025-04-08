echo custom_startup.sh

sudo apt update
sudo apt install -y libevent-dev
sudo apt install -y gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad
sudo apt install -y libavif-dev

cd ~/

USERNAME=jeongzmin%40plateer.com
PASSWORD=456456aa

git clone https://$USERNAME:$PASSWORD@gitlab.x2bee.com/tech-team/ai-team/agent/web-agent.git

cd ~/web-agent

curl -LsSf https://astral.sh/uv/install.sh | sh

echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
export PATH="$HOME/.local/bin:$PATH"

echo uv-start

uv venv .venv
uv sync
uv pip install playwright
uv tool run playwright install

echo uv-end

wget "https://www.wfonts.com/download/data/2016/06/13/malgun-gothic/malgun.ttf"
mv malgun.ttf /usr/share/fonts/truetype/

echo custom_startup.sh end