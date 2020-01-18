FROM bitnami/minideb:buster

MAINTAINER Ben Eriksson (CMNatic) "https://cmnatic.co.uk"


# cOPY ARGS to pathing, etc
COPY ARGS.sh /usr/bin/ARGS
COPY CONFIG.sh /etc/

RUN apt-get -qq update && \
	DEBIAN_FRONTEND=noninteractive \
		apt-get -y --no-install-recommends -qq install \
			openssh-server && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists* /tmp/* /var/tmp/* && \
	chmod +x /etc/CONFIG.sh

WORKDIR /etc/ssh

# Take values from ARGS and modify sshd_config accordingly
RUN \
	echo "root:$(ARGS ROOT_PASSWORD)" | chpasswd && \
	echo "Successfully changed root password" && \
	\
	sed --in-place 's/^\(PermitRootLogin\|UsePAM\|UseDNS\)/#\1/' sshd_config && \
	echo "" >> sshd_config && \
	echo "PermitRootLogin $(ARGS PERMIT_ROOT_LOGIN)" >> sshd_config && \
	echo "UsePAM $(ARGS USE_PAM)" >> sshd_config && \
	echo "UseDNS $(ARGS USE_DNS)" >> sshd_config && \
	\
	rm /usr/bin/ARGS /etc/CONFIG.sh

RUN service ssh start

EXPOSE 22

CMD [ "/usr/sbin/sshd", "-D"]
