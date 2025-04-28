## 필수 라이브러리 설치
sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y vim
sudo yum install -y yum-utils
sudo dnf install -y ca-certificates
sudo dnf install -y net-tools
sudo yum install -y ipvsadm 

## 방화벽 해체
sudo systemctl stop firewalld
sudo systemctl disable firewalld

## hosts 설정
declare -A hosts
hosts["192.168.2.172"]="k8s-master master"
hosts["192.168.2.173"]="k8s-worker01 worker01"
hosts["192.168.2.177"]="k8s-worker02 worker02"

## hosts 네임 설정 ex) k8s-worker02
read -p "hostname을 입력하고 Enter : " new_hostname
sudo hostnamectl set-hostname $new_hostname

## docker 활성화 재설정
sudo systemctl enable docker
sudo systemctl start docker

## docker 기타 설정
SupplementaryGroups=docker
sudo chmod 666 /var/run/docker.sock
sudo chgrp docker /lib/systemd/system/docker.socket
sudo chmod g+w /lib/systemd/system/docker.socket
ls -l /lib/systemd/system/docker.socket

## docker 스왑 설정
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

## 커널 설정
modprobe overlay
modprobe br_netfilter

cat > /etc/modules-load.d/k8s.conf << EOF
overlay
br_netfilter
EOF

## 쿠버네티스 설치 설정
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.30/rpm/repodata/repomd.xml.key
exclude=kubelet kubeadm kubectl cri-tools kubernetes-cni
EOF

cat > /etc/sysctl.d/k8s.conf << EOF
net.ipv4.ip_forward = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

## 컨테이너디 설치 설정
sudo dnf repolist
sudo dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf update
sudo dnf install containerd.io

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo dnf install -y dnf-plugins-core device-mapper-persistent-data lvm2

sudo modprobe overlay
sudo modprobe br_netfilter
sudo sysctl --system

cd /etc/containerd
sudo cp /etc/containerd/config.toml /etc/containerd/config.toml.orig
sudo sh -c 'sudo containerd config default > /etc/containerd/config.toml'
sudo containerd config default > /etc/containerd/config.toml

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl enable --now containerd
sudo systemctl is-enabled containerd
sudo systemctl stop containerd
sudo systemctl start containerd
sudo systemctl enable --now containerd.service

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf  
net.bridge.bridge-nf-call-iptables = 1  
net.bridge.bridge-nf-call-ip6tables = 1  
net.ipv4.ip_forward = 1  
EOF

modprobe br_netfilter
sudo sysctl --system

sudo dnf update
sudo dnf repolist
sudo dnf makecache

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes

sudo systemctl enable kubelet.service
sudo systemctl enable --now kubelet

sudo sed -i 's/^SELINUX=permissive$/SELINUX=disabled/' /etc/selinux/config