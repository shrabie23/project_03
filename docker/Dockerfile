FROM debian:latest
LABEL maintainer="Rabie <rabie.sihammou@gmail.com>"
ENV HOME=/home/vagrant \
    USER=vagrant

# Install ngnix
RUN apt-get update \
&& apt-get install -qq -y --no-install-recommends openssh-server nginx > /dev/null \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Change root permission and root password 
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
&& sed -i 's/#PermitRootLogin/PermitRootLogin/' /etc/ssh/sshd_config \
&& sed -i 's#root:\*#root:sa3tHJ3/KuYvI#' /etc/shadow

# Add vagrant user
RUN useradd -m -p sa3tHJ3/KuYvI ${USER} \
&& mkdir $HOME/.ssh \
&& chmod 700 $HOME/.ssh \
&& chown $USER:$USER $HOME/.ssh

# Copy hote ssh public key to docker container
COPY ./ssh/id_rsa.pub $HOME/.ssh/authorized_keys
RUN chmod 600 $HOME/.ssh/authorized_keys \
&& chown $USER:$USER $HOME/.ssh/authorized_keys \
&& service ssh start

# Init configuration script
ADD ./init_conf.sh /tmp/
RUN chmod +x /tmp/init_conf.sh

# Define work directory
WORKDIR ${HOME}

# Expose http and ssh ports
EXPOSE 80 22

# Run configuration
CMD ["sh", "/tmp/init_conf.sh"] 
