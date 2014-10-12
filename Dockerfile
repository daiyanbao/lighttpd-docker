FROM centos

EXPOSE 22 81

RUN yum -y install wget
RUN yum -y install openssh
RUN yum -y install openssh-server
RUN yum -y install openssh-clients
RUN yum -y install passwd
RUN yum -y install net-tools

RUN yum -y install gcc make zlib-devel bzip2 bzip2-devel
RUN yum -y install pcre pcre-devel
RUN yum -y install gdbm gdbm-devel
RUN yum -y install httpd


RUN echo 'root:password' | chpasswd
RUN ["useradd", "test"]
RUN echo 'test:password' | chpasswd

RUN ["/usr/sbin/sshd-keygen", "-t", "rsa", "-N", "", "-f", "/etc/ssh/ssh_host_rsa_key"]
RUN ["/usr/sbin/sshd-keygen", "-t", "ecdsa", "-N", "", "-f", "/etc/ssh/ssh_host_rotecdsa_key"]

# install supervisor
RUN wget  http://peak.telecommunity.com/dist/ez_setup.py
RUN python ez_setup.py
RUN easy_install supervisor
#RUN mkdir /root/lighttpd
VOLUME /root/lighttpd

COPY supervisord.conf /usr/etc/supervisord.conf
RUN mkdir /root/conf/
COPY lighttpd.conf /root/conf/lighttpd.conf

CMD ["/usr/bin/supervisord"]
