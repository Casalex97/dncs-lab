export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-a

ip link set dev enp0s8 up
ip addr add 123.0.1.2/25 dev enp0s8

ip route del default
ip route add default via 123.0.1.1






