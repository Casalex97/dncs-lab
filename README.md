# DNCS-LAB

This repository contains the Vagrant files required to run the virtual lab environment used in the DNCS course.
```


        +-----------------------------------------------------+
        |                                                     |
        |                                                     |eth0
        +--+--+                +------------+             +------------+
        |     |                |            |             |            |
        |     |            eth0|            |eth2     eth2|            |
        |     +----------------+  router-1  +-------------+  router-2  |
        |     |                |            |             |            |
        |     |                |            |             |            |
        |  M  |                +------------+             +------------+
        |  A  |                      |eth1                       |eth1
        |  N  |                      |                           |
        |  A  |                      |                           |
        |  G  |                      |                     +-----+----+
        |  E  |                      |eth1                 |          |
        |  M  |            +-------------------+           |          |
        |  E  |        eth0|                   |           |  host-c  |
        |  N  +------------+      SWITCH       |           |          |
        |  T  |            |                   |           |          |
        |     |            +-------------------+           +----------+
        |  V  |               |eth2         |eth3                |eth0
        |  A  |               |             |                    |
        |  G  |               |             |                    |
        |  R  |               |eth1         |eth1                |
        |  A  |        +----------+     +----------+             |
        |  N  |        |          |     |          |             |
        |  T  |    eth0|          |     |          |             |
        |     +--------+  host-a  |     |  host-b  |             |
        |     |        |          |     |          |             |
        |     |        |          |     |          |             |
        ++-+--+        +----------+     +----------+             |
        | |                              |eth0                   |
        | |                              |                       |
        | +------------------------------+                       |
        |                                                        |
        |                                                        |
        +--------------------------------------------------------+



```

# Requirements
 - Python 3
 - 10GB disk storage
 - 2GB free RAM
 - Virtualbox
 - Vagrant (https://www.vagrantup.com)
 - Internet

# How-to
 - Install Virtualbox and Vagrant
 - Clone this repository
`git clone https://github.com/dustnic/dncs-lab`
 - You should be able to launch the lab from within the cloned repo folder.
```
cd dncs-lab
[~/dncs-lab] vagrant up
```
Once you launch the vagrant script, it may take a while for the entire topology to become available.
 - Verify the status of the 4 VMs
 ```
 [dncs-lab]$ vagrant status                                                                                                                                                                
Current machine states:

router                    running (virtualbox)
switch                    running (virtualbox)
host-a                    running (virtualbox)
host-b                    running (virtualbox)
```
- Once all the VMs are running verify you can log into all of them:
`vagrant ssh router`
`vagrant ssh switch`
`vagrant ssh host-a`
`vagrant ssh host-b`
`vagrant ssh host-c`

# Assignment
This section describes the assignment, its requirements and the tasks the student has to complete.
The assignment consists in a simple piece of design work that students have to carry out to satisfy the requirements described below.
The assignment deliverable consists of a Github repository containing:
- the code necessary for the infrastructure to be replicated and instantiated
- an updated README.md file where design decisions and experimental results are illustrated
- an updated answers.yml file containing the details of 

## Design Requirements
- Hosts 1-a and 1-b are in two subnets (*Hosts-A* and *Hosts-B*) that must be able to scale up to respectively 291 and 176 usable addresses
- Host 2-c is in a subnet (*Hub*) that needs to accommodate up to 95 usable addresses
- Host 2-c must run a docker image (dustnic82/nginx-test) which implements a web-server that must be reachable from Host-1-a and Host-1-b
- No dynamic routing can be used
- Routes must be as generic as possible
- The lab setup must be portable and executed just by launching the `vagrant up` command

## Tasks
- Fork the Github repository: https://github.com/dustnic/dncs-lab
- Clone the repository
- Run the initiator script (dncs-init). The script generates a custom `answers.yml` file and updates the Readme.md file with specific details automatically generated by the script itself.
  This can be done just once in case the work is being carried out by a group of (<=2) engineers, using the name of the 'squad lead'. 
- Implement the design by integrating the necessary commands into the VM startup scripts (create more if necessary)
- Modify the Vagrantfile (if necessary)
- Document the design by expanding this readme file
- Fill the `answers.yml` file where required (make sure that is committed and pushed to your repository)
- Commit the changes and push to your own repository
- Notify the examiner that work is complete specifying the Github repository, First Name, Last Name and Matriculation number. This needs to happen at least 7 days prior an exam registration date.

# Notes and References
- https://rogerdudler.github.io/git-guide/
- http://therandomsecurityguy.com/openvswitch-cheat-sheet/
- https://www.cyberciti.biz/faq/howto-linux-configuring-default-route-with-ipcommand/
- https://www.vagrantup.com/intro/getting-started/


# Assignment Design description:

### IP addressing:
 To have the least possible usage of IP address I have to assign, to the hosts and routers, the address class that are able to accomodate in a number immediatly greater then the request. In this case, for example, to the host-a I have assigned, in order to respect requirements, a 507 usable subnet adresses. Therefore it is also possible to add other hosts without change the subnet-mask and the ip adresses. The table below shows the network's IP:


 Per avere il minore spreco possibile di indirizzi IP devo assegnare ai vari host e router le classi di indirizzi che permettono di ospitarne in numero immediatamente maggiore alla richiesta. In questo caso, ad esempio, per l'host-a si è dovuto assegnare, per rispettare i requisiti, una subnet che può contenere fino a 507 indirizzi utilizzabili. Perciò è possibile anche aggiungere molti altri host senza modificare la subnet-mask e gli indirizzi dei dispositivi. Di seguito i vari indirizzamenti:

|    Device/Subnet   |    Subnet mask   | Network address |
|:----------------:|:---------------------:|:-----------------:|
|    **Host-a**    | /23 - 255.255.254.0   |     172.16.0.0    |
|    **Host-b**    | /24 - 255.255.255.0   |     172.16.2.0    |
|    **Router-1 <--> Router-2**  | /30 - 255.255.255.252 |   172.16.3.128  | 
|    **Host-c**    | /25 - 255.255.255.128 |     172.16.3.0    |

#### Host-A subnet
 About 291 possible usable addresses are required, so i have assigned to the host-a the address: **172.16.0.2/23** in this whay the subnet can support up to 507 addresses. The brodcast, network and router-1 (for VLAN) address is add to this addresses.


 Sono richiesti almeno 291 possibili indirizzi utilizzabili perciò assegno all'host-a l'indirizzo **172.16.0.2/23** in    questo modo la sottorete può supportare fino 507 indirizzi più uno di broadcast, uno di rete e infine uno riservato al router-1 per la VLAN.

#### Host-B subnet
 About 176 possible usable addresses are required, so i have assigned to the host-b the address: **172.16.2.2/24** in this whay the subnet can support up to 252 addresses. The brodcast, network and router-1 (for VLAN) addresses is add to this addresses.

 Sono richiesti almeno 176 possibili indirizzi utilizzabili perciò assegno all'host-b l'indirizzo **172.16.2.2/24** in    questo modo la sottorete può supportare fino 252 indirizzi più uno di broadcast, uno di rete e infine uno riservato al router-1 per la VLAN.

#### Host-C subnet
 About 95 possible usable addresses are required, so i have assigned to the host-b the address: **172.16.3.2/25** in this whay the subnet can support up to 124 addresses. The brodcast, network and router-2 (gateway) addresses is add to this addresses.
 
 Sono richiesti almeno 95 possibili indirizzi utilizzabili perciò assegno all'host-b l'indirizzo **172.16.3.2/25** in      questo modo la sottorete può supportare fino 124 indirizzi più uno di broadcast e uno di rete e infine uno riservato al router-2 cioè il gateway.

#### Subnet between Router-1 e Router-2
 Ai due router collegati è possibile assegnare una /30 rete, in questo caso ho assegnato al router-1 l'indirizzo **172.16.3.129/30** e al router-2 l'indirizzo **172.16.3.130/30**.

 To the two router connected is possible to assign a /30 subnet. In this case i assigned to router-1 the **172.16.3.129/30** addresses and for router-2 the address **172.16.3.130/30**.

### VLAN configuration:
 Solamente l'host-a e l'host-b appartengono a due VLAN differenti, invece l'host-c non è associato a nessuna VLAN.  
 Per la configurazione delle VLAN devo aggiungere allo switch le porte con il tag 10 corrispondente all'host-a e con il tag 20 per l'host-b. Successivamente, per connettere il router-1 alle due VLAN, aggiungo un trunk link. Solo in questo modo l'host-a e l'host-b potranno comunicare, anche se sono in due VLAN differenti, tramite il router-1. Quest'ultimo comunica con lo switch collegandosi alla porta con il tag 10 o 20 in base alla VLAN di destinazionennnn

A different VLAN is associated for the host-a and host-b, instead the host-c is not a part of a VLAN.
For the VLAN configuration i have to add to the switch the port with tag 10 which match with host-a and the port with tag 20 for host-b. After this, i need to add a trunk link between router-1 and switch for VLAN connection. Only in this way can host-a and host-b communicate through the router-1, although they are in two different VLANs. Router-1 is connected to the router with ports 20 and 10 based on belonging VLAN.

#### Interface corresponding to the network scheme (up):
- eth0 = enp0s3
- eth1 = enp0s8
- eth2 = enp0s9
- eth3 = enp0s10

### Descrizione della configurazione dei vari dispositivi:
### Configuration description of devices:

#### Host-A
- Added IP addres: 172.16.0.2/23 over enp0s8 interface
- Enp0s8 port connection enabled
- Delete routes configure by default
- Add the default route to router-1 address 172.16.0.1 for VLAN 10
 
- Aggiunto l'indirizzo IP: 172.16.0.2/23 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate di default
- Aggiungo la rotta di default verso il router-1 all'indirizzo 172.16.0.1 per la VLAN 10

#### Host-B
- Added IP addres: 172.16.2.2/24 over enp0s8 interface
- Enp0s8 port connection enabled
- Delete routes configure by default
- Add the default route to router-1 address 172.16.2.1 for VLAN 20

- Aggiunto l'indirizzo IP: 172.16.2.2/24 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate di default 
- Aggiungo la rotta di default verso il router-1 all'indirizzo 172.16.2.1 per la VLAN 20

#### Host-C
- Docker istall commands and pull of the image: dustnic82/nginx-test
- I provide the command to start the nginx web server in the background, so that it can be reached by other hosts via port 80
- Added IP addres: 172.16.3.2/25 over enp0s8 interface
- Enp0s8 port connection enabled
- Delete routes configure by default
- Add the default route to router-2 address 172.16.3.1

- Installo docker e faccio il pull dell'immagine: dustnic82/nginx-test
- Do il comando per avviare in background il web server di nginx, in modo che sia raggiungibile dagli altri host attraverso la porta 80
- Aggiunto l'indirizzo IP: 172.16.3.2/25 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate di default
- Aggiungo la rotta di default verso il router-2 all'indirizzo 172.16.3.1

### Switch
- I provide the command to redefine host that it can work like a switch (sudo ovs-vsctl add-br switch)
- I add the port enp0s9 configured on the VLAN tagged with 10
- I add the port enp0s10 configured on the VLAN tagged with 20
- Add the enp0s8 port that connects the switch to router-1 via a trunk link to pass different VLAN packets 
- Activate all newly created ports and those already defined in the switch

- Inserisco il comando per ridefinire l'host in modo che lavori come uno switch (sudo ovs-vsctl add-br switch)
- Aggiungo la porta enp0s9 configurata sulla VLAN taggata con 10
- Aggiungo la porta enp0s10 configurata sulla VLAN taggata con 20
- Aggiungo la porta enp0s8 che connette lo switch al router-1 tramite un trunk-link per fare transitare i pacchetti di VLAN diverse
- Attivo tutte porte appena create e quelle già definite nello switch

### Router-1
- Insert the command to allow the device to redirect (forward) the packets
- Add and activate the ports enp0s8.10 and enp0s8.20 corresponding to the VLANs tagged with 10 and 20
- Add and activate the port enp0s9 which will serve as a connection for router-2
- Added IP addres: 172.16.0.1/23 over enp0s8.10 interface
- Added IP addres: 172.16.2.1/24 over enp0s8.20 interface
- Added IP addres: 172.16.3.129/30 over enp0s9 interface
- Delete routes configure by default
- Add a NEXT-HOP route that allows the host-c destination packet to be redirected to the router-2 interface

- Inserisco il comando per permettere al dispositivo di reindirizzare (forward) i pacchetti
- Aggiungo e attivo le porte enp0s8.10 e enp0s8.20 corrispondenti alle VLAN taggate con 10 e 20
- Aggiungo e attivo la porta enp0s9 che servirà come collegamento per il router-2
- Aggiunto l'indirizzo IP: 172.16.0.1/23 sull'interfaccia enp0s8.10
- Aggiunto l'indirizzo IP: 172.16.2.1/24 sull'interfaccia enp0s8.20
- Aggiunto l'indirizzo IP: 172.16.3.129/30  sull'interfaccia enp0s9
- Elimino le rotte configurate di default
- Aggiungo una rotta di NEXT-HOP che permette al pacchetto di destinazione host-c di essere reindirizzati verso l'interfaccia del router-2

### Router-2
- Insert the command to allow the device to redirect (forward) the packets
- Enp0s8 port connection enabled
- Enp0s9 port connection enabled
- Added IP addres: 172.16.3.1/25 over enp0s8 interface
- Added IP addres: 172.16.3.130/30 over enp0s9 interface
- Delete routes configure by default
- Add default route with IP addres 172.16.3.129 (router-1 addres towards router-2)

- Inserisco il comando per permettere al dispositivo di reindirizzare (forward) i pacchetti
- Aggiungo e attivo la porta enp0s9 
- Aggiungo e attivo la porta enp0s8 
- Aggiunto l'indirizzo IP: 172.16.3.1/25 sull'interfaccia enp0s8
- Aggiunto l'indirizzo IP: 172.16.3.130/30 sull'interfaccia enp0s9
- Elimino le rotte configurate di default
- Aggiungo la rotta di default all'indirizzo 172.16.3.129 cioè quello del router-1 


## Docker image 
- To verify the correct working of Docker simply execute: "curl 172.16.3.2", in the host-a or host-b subnet
- This command is able to request to host-c addres the web server page, it displayed with HTML, trough 80 port
- This command allows to request the web-server page, in HTML, through the port 80 for the host-c address

- Per verificare il corretto funzionamento del docker basta semplicemente eseguire: " curl 172.16.3.2 ", dalle subnet dell'host-a o dell'host-b. Questo comando permette di richiedere all'indirizzo dell'host-c la pagina del web-server, in HTML, attraverso la porta 80.


