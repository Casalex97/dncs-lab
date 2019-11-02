export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-b

#devo inserire un ip
    
sudo sysctl net.ipv4.ip_forward=1


# Set-up the interfaces
sudo ip link add link enp0s8 name enp0s8.10 type vlan id 10
sudo ip link add link enp0s8 name enp0s8.20 type vlan id 20
sudo ip link set dev enp0s8 up
sudo ip link set dev enp0s9 up
sudo ip link set dev enp0s8.10 up
sudo ip link set dev enp0s8.20 up

sudo ip addr add 145.10.1.2/23 dev enp0s8.10
sudo ip addr add 145.11.1.2/24 dev enp0s8.20
sudo ip addr add 145.12.1.1/30 dev enp0s9

#Delete default route (by Vagrant DHCP)
sudo ip route del default
#sudo ip route add 10.0.1.32/30 via 145.12.1.2