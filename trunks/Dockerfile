# Copyright 2024 Louis Royer. All rights reserved.
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
# SPDX-License-Identifier: MIT

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

COPY ./*.sh /usr/local/bin/
COPY ./template.yaml /usr/local/share/trunks/template.yaml
ENV ROUTING_SCRIPT="" \
    TEMPLATE_SCRIPT="template-script.sh" \
    TEMPLATE_SCRIPT_ARGS="" \
    CONFIG_FILE="/etc/trunks/trunks.yaml" \
    CONFIG_TEMPLATE="/usr/local/share/trunks/template.yaml"

ENTRYPOINT ["entrypoint.sh"]
CMD ["--help"]
