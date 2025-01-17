FROM ubuntu:22.04

RUN apt-get update \
    && apt-get install -y init gpg ca-certificates sudo curl \
    && apt-get clean all

# Adding fake systemctl
RUN curl https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl3.py -o /usr/local/bin/systemctl
RUN chmod +x /usr/local/bin/systemctl

CMD ["/usr/local/bin/systemctl"]