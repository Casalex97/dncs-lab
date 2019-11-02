export DEBIAN_FRONTEND=noninteractive
# Startup commands go here for host-a

    #sudo ip add add 145.10.1.0/23 dev enp0s8
    #sudo ip link set enp0s8 up
    #sudo ip route del 10.0.2.0/24
    #sudo ip route del 10.0.2.2

    #aggiungo la porta all'host a con il tag vlan 10
    sudo ip link set dev enp0s8 up
    #sudo ip link add link enp0s8 name enp0s8.10 type vlan id 10
    sudo ip add add 145.10.1.1/23 dev enp0s8
    #sudo ip link set dev enp0s8.10 up

    sudo ip route del default
    
    sudo ip route add default via 145.10.1.2
    #ip route per vedere l'elenco del routing in questo caso dell'host a
    #devo inserire la defalut gateway verso il router 1
