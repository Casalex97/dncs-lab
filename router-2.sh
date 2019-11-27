export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-b

sudo sysctl net.ipv4.ip_forward=1

# Set-up the interfaces
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip addr add 172.16.3.1/25 dev enp0s8
sudo ip addr add 172.16.3.130/30 dev enp0s9

sudo ip route del default
sudo ip route add default via 172.16.3.129
