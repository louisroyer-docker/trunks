FROM louisroyer/base-irit:latest

LABEL maintainer="Louis Royer <louis.royer@irit.fr>" \
      org.opencontainers.image.authors="Louis Royer <louis.royer@irit.fr>" \
      org.opencontainers.image.source="https://github.com/louisroyer-docker/trunks"

# Used to disable caching of next steps, if not build since 1 day,
# allowing to search and apply security upgrades
ARG BUILD_DATE=""

RUN apt-get update -q && DEBIAN_FRONTEND=non-interactive apt-get install -qy --no-install-recommends --no-install-suggests \
    trunks \
    && apt-get upgrade -qy \
    && rm -rf /var/lib/apt/lists/*

COPY ./entrypoint.sh /usr/local/bin/entrypoint.sh
ENV ROUTING_SCRIPT=""

COPY ./template-script.sh /usr/local/bin/template-script.sh
ENV TEMPLATE_SCRIPT="template-script.sh"
ENV TEMPLATE_SCRIPT_ARGS=""

COPY ./template.yaml /etc/trunks/template.yaml
ENV CONFIG_FILE="/etc/trunks/trunks.yaml"
ENV CONFIG_TEMPLATE="/etc/trunks/template.yaml"

ENTRYPOINT ["entrypoint.sh"]
CMD ["--help"]
