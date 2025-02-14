export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-c

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common --assume-yes 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt-get upgrade
apt-cache policy docker-ce
sudo apt install docker-ce --assume-yes 
sudo systemctl status docker
docker pull dustnic82/nginx-test
sudo docker run --name nginx-test -p 80:80 -d nginx

ip link set dev enp0s8 up
ip addr add 172.16.3.2/25 dev enp0s8
ip route del default
ip route add default via 172.16.3.1




