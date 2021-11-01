# Cybersecurity-Portfolio## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![Red Team Network Diagram](https://github.com/oxa111/Cybersecurity-Portfolio/blob/131b76375282d22c56fb99b09bb76bc58f2c1d01/Diagrams/RedTeam_NetworkDiagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the Configuration and YAML files may be used to install only certain pieces of it, such as Filebeat.

  * [Ansible Configuration](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/ansible.cfg)
  * [Ansible Hosts](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/hosts.txt)
  * [Ansible Playbook](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/pentest.yml)
  * [ELK Installation and Configuration](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/install-elk.yml)
  * [Filebeat Configuration](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/file-beat-config.yml)
  * [Filebeat Playbook](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/filebeat-playbook.yml)
  * [Metricbeat Configuration](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/metricbeat-config.yml)
  * [Metricbeat Playbook](https://github.com/oxa111/Cybersecurity-Portfolio/blob/ab48a13367f53cb11698447fdd148bae3b0b4a3b/Ansible/metricbeat-playbook.yml)

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.
Load balancing ensures that the application will be highly available, in addition to restricting access to the network.  The addition of a load balancer into the network will ensure availability of services by acting as a reverse proxy and distributing network traffic across servers located in the backend pool.  In addition, the implementation of a load balancer to the network will add a layer of security and help mitigate the risk of a DDoS attack.  The ability to reroute traffic will bring resiliency to the network and eliminate a single point of failure in the event of a security event.

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the data and system logs.
An ELK stack will be deployed on the network to set up a cloud monitoring system.  In order to monitor changes to files and track specific information, an instance of Filebeat and Metricbeat will be installed on each web server running an instance of DVWA.  Filebeat will collect log events and gather data about the file system.  In addition, Metricbeat will be used to monitor and collect metrics from the system and services running on each server.  

The configuration details of each machine may be found below.


| Name                | Function                                  | IP Address    | Operating System       |
|---------------------|-------------------------------------------|---------------|------------------------|
| Jump Box Provisioner| Gateway                                   | 10.0.0.4      | Linux Ubuntu 18.04-LTS |
| Local Workstation   | Configurating network externally          | 100.15.100.74 | Windows 10 Home Edition|
| Web-1 VM            | Process and deliver web content to user   | 10.0.0.5      | Linux Ubuntu 18.04-LTS |
| Web-2 VM            | Process and deliver web content to user   | 10.0.0.6      | Linux Ubuntu 18.04-LTS |
| ELK-Server          | Collect and process data from Web VMs     | 10.1.0.4 	  | Linux Ubuntu 18.04-LTS |
| Load Balancer       | Distribute Traffic to backend server pool | 13.68.250.112 | N/A                    |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jumpbox Provisioner machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
  * Local Workstation with public IP address of 100.15.100.74 has been whitelisted. This machine has the ability to access the Jump Box via SSH through port 22.

Machines within the network can only be accessed by the Jumpbox Provisioner.
  * Jumpbox Provisioner with private IP address of 10.0.0.4 can access the ELK VM via SSH on port 22.
  * Local workstation computer with public IP address 100.15.100.74 via TCP Port 5601

A summary of the access policies in place can be found in the table below.

| Name          | Publicly Accessible | Allowed IP Addresses                                                     |
|---------------|---------------------|--------------------------------------------------------------------------|
| Jump Box      | Yes                 | Local Workstation with IP 100.15.100.74 via SSH port 22                  |
| Web-1 VM      | No                  | 10.0.0.4 via SSH port 22                                                 |
| Web-1 VM      | No                  | 10.0.0.4 via SSH port 22                                                 |
| ELK Server    | Only on Port 5601   | Local Workstation with IP 100.15.100.74 via port 5601, 10.0.0.4          |
| Load Balancer | Yes                 | Local Workstation with IP 100.15.100.74 via HTTP port 80                 | 

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because manual configuration is time consuming and can lead to human error.  Automated configuration through the Ansible provisioning tool provides greater efficiency, as several machines can be figured at the same time, and provides homogeneous configurations, which will ensure that all machines deployed and running the provisional script will be identical to one another.  

The playbook implements the following tasks:

  * The first step in the playbook specifies the remote user as RedAdmin and indicates that the hosts in the “elk” group of machines will be configured.  Previously, the IP address of the ELK Server was added in the Ansible hosts file under the “elk” group of machines.  
  
   name: Configure Elk VM with Docker
   hosts: elk
   remote_user: RedAdmin
   become: true
   tasks:

  * The playbook then was configured to install the Docker engine used to run containers, called docker.io.

     - name: Install docker.io
       apt:
         update_cache: yes
         name: docker.io
         state: present

  * In the third step, the python3-pip package was installed, which is used to run Python software.

       # Use apt module
     - name: Install pip3
       apt:
         force_apt_get: yes
         name: python3-pip
         state: present

  * Ansible requires the Docker Python client to control Docker Containers.  In the next step the playbook will indicate the installing of this Docker Python module.

       # Use pip module
     - name: Install Docker python module
       pip:
         name: docker
         state: present

  * The next step in the playbook will help ensure the ELK server utilizes the proper amount of memory required to run.

       # Use sysctl module
     - name: Use more memory
       sysctl:
         name: vm.max_map_count
         value: "262144"
         state: present
         reload: yes

  * The playbook will be configured to install the ELK Docker container called sebp/elk:761

       # Use docker_container module
     - name: download and launch a docker elk container
       docker_container:
         name: elk
         image: sebp/elk:761
         state: started
         restart_policy: always

  * In the final step of the playbook, the port mappings will be defined.

        published_ports:
           - 5601:5601
           - 9200:9200
           - 5044:5044


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![Docker PS Output](https://github.com/oxa111/Cybersecurity-Portfolio/blob/76dca1c18a8173aa49d05faae52f2b2068969b58/Diagrams/Images/docker%20ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:

  *  Web-1 VM: 10.0.0.5
  *  Web-2 VM: 10.0.0.6

We have installed the following Beats on these machines:

  *  Filebeat
  *  Metricbeat

These Beats allow us to collect the following information from each machine:

Filebeat collects and aggregates various log events regarding the file systems on a host.   For example, we can process logs for SSH logins to determine successful and failed login attempts into the system. 
Metricbeat reports on the health of a system and collects various machine metrics such as uptime, memory usage, and Network IO.   We can also specifically monitor CPU usage on a host and determine if it is being used as expected or is being exhausted with the potential to fail.  


### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the filebeat-config.yml file to /etc/ansible/files/filebeat-config.yml.
- Update the filebeat-config.yml file to include the installation path, username/password, the IP address of the ELK server under outpout.elasticsearch within the configuration file, and the IP address and port number under the setup.kibana field.
- Run the playbook, and navigate to http://[public IP address of ELK Server]:5601/app/kibana to check that the installation worked as expected.  To confirm that the ELK server is receiving logs from Web-1 and Web-2 you will navigate from within the Kibana Gui to Add Log Data --> System Logs --> DEB tab --> Step 5: Module Status --> Check Data.

_TODO: Answer the following questions to fill in the blanks:_
- _Which file is the playbook? Where do you copy it? filebeat-playbook.yml.  It will be copied in the /etc/ansible/roles/filebeat-playbook.yml directory.
- _Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on? This can be defined within the Ansible Hosts file.  Under the "webservers" grouping, we listed the VM's that will be configured with Filebeat.  In addition, within the same file we created an "elk" group to specify the VM that will be configured with the ELK server.
- _Which URL do you navigate to in order to check that the ELK server is running? http://[public IP address of ELK Server]:5601/app/kibana

_As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc._

  * ssh RedAdmin@jump-box-ip-address
  * sudo docker pull [name of container] to download container
  * sudo docker run -ti [name of container] bash
  * sudo docker start [name of container]  to start the container
  * sudo docker attach to connect to the Ansible container
  * Navigate to the /etc/ansible directory
  * Nano hosts to configure the IP addresses within the "webserver" and "elk" groups
  * Nano ansible.cfg to specify the remote user.
  * ansible-playbook [name of playbook]
  
