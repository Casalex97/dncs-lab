export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump
apt-get install -y openvswitch-common openvswitch-switch apt-transport-https ca-certificates curl software-properties-common

# Startup commands for switch go here
sudo ovs-vsctl add-br switch
sudo ovs-vsctl add-port switch enp0s8
sudo ip link set enp0s8 up


