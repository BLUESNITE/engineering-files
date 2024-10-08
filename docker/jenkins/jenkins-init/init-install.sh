cd /usr/local/bin/
curl -LO https://github.com/argoproj/argo-cd/releases/download/v2.11.2/argocd-linux-amd64
mv argocd-linux-amd64 argocd
chmod 755 /usr/local/bin/argocd
argocd version
