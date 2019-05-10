FROM rancher/rancher:v2.2.2

COPY certinit.sh /usr/bin/
RUN chmod +x /usr/bin/certinit.sh

ENTRYPOINT ["certinit.sh"]
