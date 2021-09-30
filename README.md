<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/MarkProminic/Vagrant-MongoDB/">
    <img src="conf/wiki/images/Prom.jpg" alt="Logo" width="200" height="100">
  </a>

  <h3 align="center">MongoDB Vagrant Server</h3>

  <p align="center">
    An README to jumpstart your build of the MongoDB
    <br />
    <a href="https://github.com/MarkProminic/Vagrant-MongoDB/"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/MarkProminic/Vagrant-MongoDB/">View Demo</a>
    ·
    <a href="https://github.com/MarkProminic/Vagrant-MongoDB/issues">Report Bug</a>
    ·
    <a href="https://github.com/MarkProminic/Vagrant-MongoDB/issues">Request Feature</a>
  </p>
</p>


# MongoDB
MongoDB is a source-available cross-platform document-oriented database program. Classified as a NoSQL database program, MongoDB uses JSON-like documents with optional schemas. MongoDB is developed by MongoDB Inc. and licensed under the Server Side Public License (SSPL).


MongoDB and Vagrant
For the sake of easy testing and instance creation, this project has utilized [Vagrant](http://www.vagrantup.com) for easy creation of the necessary virtual machines to run a Switchboard instance.


## Creating a MongoDB instance using Vagrant
The first step in spinning up a MongoDB instance is to clone this repo:

```git clone https://github.com/MarkProminic/Vagrant-MongoDB```

Next you will need to install Vagrant on your machine by following the instructions [here](https://www.vagrantup.com/docs/installation/).

This can be done by entering the following commands in a terminal:
```
cd Vagrant-MongoDB
```
# Changing Vagrant VM IPs
Now Modify your Hosts.yml file to suit your local network and any other configurations you want to define for the VM, The IPs of the  Vagrant VMs are configured statically by the Vagrantfile used to provision them. In order to change these IP adresses, you will need to change the configuration in the Hosts.yml in the root of this repo, for each VM(aka Host) and change your hosts file to reflect these changes. For example, in order to change the IP of vagrant VM to `172.16.0.0`, you need only change the following line:
```
nano Hosts.yml
```
The lines you are looking for:
```
    gateway: "172.16.66.1"
    identifier: mongodb-01.int.dc-01.mydomain.net
    ip: "172.16.66.3"
    mac: 52540fc9cf91
    name: mongodb-01.int.dc-01.mydomain.net
    netmask: "255.255.0.0"
```
 to include the desired address instead:
 
 ```
    gateway: "172.16.66.1"
    identifier: mongodb-01.int.dc-01.mydomain.net
    ip: "172.16.0.0"
    mac: 52540fc9cf91
    name: mongodb-01.int.dc-01.mydomain.net
    netmask: "255.255.0.0"
 ```
 
 Then you can Bring up the machine 

```
vagrant up
```
This will run the Vagrantfile to start and provision the VM using VirtualBox. Vagrant may prompt you to specify which network device to bridge to if your machine has more than one, just choose the one that is used for public network access.

## Built With
* [Vagrant](https://www.vagrantup.com/) - Portable Development Environment Suite.
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads) - Hypervisor.
* [Ansible](https://www.ansible.com/) - Virtual Manchine Automation Management.
* [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) - A Vagrant plugin to keep your VirtualBox Guest Additions up to date.
* [vagrant-reload](https://github.com/aidanns/vagrant-reload) - A Vagrant plugin that allows you to reload a Vagrant plugin as a provisioning step.
* [vagrant-disksize](https://github.com/sprotheroe/vagrant-disksize) - A Vagrant plugin to resize disks in VirtualBox.


## Contributing

Please read [CONTRIBUTING.md](https://www.prominic.net) for details on our code of conduct, and the process for submitting pull requests to us.

## Authors

* **Mark Gilbert** - *Automation* - [Makr91](https://github.com/Makr91)

## License

This project is licensed under the SSPL v3 License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone whose code was used
