export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-b

    sudo ip link set dev enp0s8 up
    sudo ip add add 172.16.2.2/24 dev enp0s8
    sudo ip route del default
    sudo ip route add default via 172.16.2.1