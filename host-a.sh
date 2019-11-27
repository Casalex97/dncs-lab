export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-a
    sudo ip link set dev enp0s8 up
    sudo ip add add 172.16.0.2/23 dev enp0s8
    sudo ip route del default
    sudo ip route add default via 172.16.0.1

