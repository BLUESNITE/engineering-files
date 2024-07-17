echo "argocd 1"

apt-get update
apt-get install -y curl git
cd /usr/local/bin/
curl -LO https://github.com/argoproj/argo-cd/releases/download/v2.11.2/argocd-linux-amd64
mv argocd-linux-amd64 argocd
chmod 755 /usr/local/bin/argocd
argocd version

echo "argocd end"

echo "docker 1"

apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

echo "docker 2"

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

echo "docker 3"

docker --version

echo "docker end"
