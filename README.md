# Use vagrant to create the local development environment
The Vagrantfile contains all the instructions for creating a Debian-based virtual machine with the docker, vim and ansible utilities.

### Run installation
First we have to install virtual box and vagrant on our machine
```
sudo apt update
sudo apt-get install vagrant
```
Then we run environment installation
```
vagrant Vagrantfile
```
### Verify installation

#### 1- Debian VM
At this step, we have created a VM named debian-dev
```
vagrant status           
Current machine states:
debian-dev                running (virtualbox)
```
we can also connect to this machine by using vagrant ssh
```
vagrant ssh debian-dev
```
or directly (192.168.10.2 is the IP address for your VM)

```
ssh vagrant@192.168.10.2  
```
use vagrant as password

#### 2- Utilities
On our VM, we have to ckeck Ansible, docker , docker-compose and vim installation

```
vagrant@debian-dev:~$ docker --version
Docker version 19.03.12, build 48a66213fe
```
```
vagrant@debian-dev:~$ docker-compose --version
docker-compose version 1.24.1, build 4667896b
```
```
vagrant@debian-dev:~$ ansible --version
ansible 2.7.7
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/vagrant/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.7.3 (default, Dec 20 2019, 18:57:59) [GCC 8.3.0]
```
```
vagrant@debian-dev:~$ vim --version
VIM - Vi IMproved 8.1 (2018 May 18, compiled Jun 15 2019 16:41:15)
```
#### 3- Nginx container
Our Vagrantfile also created a docker container containing nginx and ssh server.
```
vagrant@debian-dev:~$ docker ps 
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                                        NAMES
51380f53cacd        rabie/nginx:latest   "sh /tmp/init_conf.sh"   2 hours ago         Up 33 minutes       0.0.0.0:2222->22/tcp, 0.0.0.0:8080->80/tcp   web
```
We can request nginx server 
```
vagrant@debian-dev:~$ curl http://localhost:8080
```
and we should have response as following:
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
To connect to the container we need its IP address 
```
vagrant@debian-dev:~$ docker inspect -f "{{ .NetworkSettings.IPAddress}}" web
172.17.0.2
```
Then:
```
ssh vagrant@172.17.0.2
Linux 51380f53cacd 4.19.0-9-amd64 #1 SMP Debian 4.19.118-2 (2020-04-29) x86_64

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Fri Jul 17 07:44:58 2020 from 172.17.0.1
$ 
```






