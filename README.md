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


# Assignment Design:

### Indirizzamento IP:
 Per avere il minore spreco possibile di indirizzi IP devo assegnare ai vari host e router le classi di indirizzi che permettono di ospitarne in numero immediatamente maggiore alla richiesta. In questo caso, ad esempio, per l'host-a si è dovuto assegnare, per rispettare i requisiti, una subnet che può contenere fino a 510 indirizzi utilizzabili. Perciò è possibile anche aggiungere molti altri host senza modificare la subnet-mask o le regole di routing. Di seguito i vari indirizzamenti:

#### Host-A
 Sono richiesti almeno 291 possibili indirizzi utilizzabili perciò assegno all'host-a l'indirizzo **145.10.1.1/23** in    questo modo la sottorete può supportare fino 510 indirizzi più uno di broadcast e uno di rete.

#### Host-B
 Sono richiesti almeno 176 possibili indirizzi utilizzabili perciò assegno all'host-b l'indirizzo **145.11.1.0/24** in    questo modo la sottorete può supportare fino 254 indirizzi più uno di broadcast e uno di rete. 

#### Host-C
 Sono richiesti almeno 95 possibili indirizzi utilizzabili perciò assegno all'host-b l'indirizzo **123.0.1.0/25** in      questo modo la sottorete può supportare fino 126 indirizzi più uno di broadcast e uno di rete. 

#### Tra Router-1 e Router-2
 Ai due router collegati è possibile assegnare una /30 rete, in questo caso ho assegnato al router-1 l'indirizzo **145.12.1.1/30** e al router-2 l'indirizzo **145.12.1.2/30**.

### Impostazione delle VLAN:
 


#### Configurazione host-A:
- Aggiunto l'indirizzo IP: 145.10.1.0/23 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate automaticamente
- 




### Host-B
- Aggiunto l'indirizzo IP: 145.11.1.0/24 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate automaticamente
### Host-C
- Aggiunto l'indirizzo IP: 123.0.1.0/25 su interfaccia enp0s8
- Attivo il collegamento della porta enp0s8
- Elimino le rotte configurate automaticamente
### Switch
- Inserisco il comando per ridefinire l'host in modo che lavori come uno switch
- Aggiungo la porta enp0s8 configurata sulla vlan taggata con 10
- Attivo la porta appena creata


