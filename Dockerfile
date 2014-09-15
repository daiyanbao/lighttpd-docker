FROM takuyai/lighttpd

EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]