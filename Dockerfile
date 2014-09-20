FROM centos

EXPOSE 22

RUN yum -y install wget
RUN yum -y install openssh
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
RUN yum -y install passwd
RUN yum -y install net-tools

RUN echo 'root:password' | chpasswd
RUN ["/usr/sbin/sshd-keygen", "-t", "rsa", "-N", "", "-f", "/etc/ssh/ssh_host_rsa_key"]
RUN ["/usr/sbin/sshd-keygen", "-t", "ecdsa", "-N", "", "-f", "/etc/ssh/ssh_host_ecdsa_key"]

CMD ["/usr/sbin/sshd","-D"]
