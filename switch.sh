export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Startup commands for switch go here
sudo ovs-vsctl add-br switch
sudo ip link set enp0s8 up
sudo ip link set enp0s9 up
sudo ip link set enp0s10 up
sudo ip link set ovs-system up
sudo ip link set switch up

#access ports
sudo ovs-vsctl --may-exist add-port switch enp0s9 tag=10
sudo ovs-vsctl --may-exist add-port switch enp0s10 tag=20

#trunk link 
sudo ovs-vsctl --may-exist add-port switch enp0s8


