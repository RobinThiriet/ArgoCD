FROM debian:latest
RUN apt-get update && apt-get install -y bash
COPY guacamole.sh /usr/local/bin/guacamole.sh
RUN chmod +x /usr/local/bin/guacamole.sh
ENTRYPOINT ["/usr/local/bin/guacamole.sh"]

