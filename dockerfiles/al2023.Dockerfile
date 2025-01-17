FROM amazonlinux:2023

# Run a system update so the system doesn't overwrite the fake systemctl later
RUN yum -y update

RUN yum -y install python3 sudo shadow-utils

# Adding fake systemctl
RUN curl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -o /usr/local/bin/systemctl

RUN chmod +x /usr/local/bin/systemctl

CMD ["/usr/local/bin/systemctl"]