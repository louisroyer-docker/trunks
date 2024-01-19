#!/usr/bin/env bash
# Copyright 2024 Louis Royer. All rights reserved.
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
# SPDX-License-Identifier: MIT

set -e
if [ -z "$ROUTING_GW_IP" ]; then
	echo "Missing mandatory environment variable (ROUTING_GW_IP)." > /dev/stderr
	exit 1
fi
if [ -z "$ROUTING_GW_NEXT_HOP" ]; then
	echo "Missing mandatory environment variable (ROUTING_GW_NEXT_HOP)." > /dev/stderr
	exit 1
fi
if [ -z "$ROUTING_ST_IP" ]; then
	echo "Missing mandatory environment variable (ROUTING_ST_IP)." > /dev/stderr
	exit 1
fi
if [ -z "$ROUTING_ST_NEXT_HOP" ]; then
	echo "Missing mandatory environment variable (ROUTING_ST_NEXT_HOP)." > /dev/stderr
	exit 1
fi

# if you absolutely need to edit the following, do a Pull Request (or use your own script directly)
TABLE_TO_GW=100
TABLE_TO_ST=101

# Forward using the other interface
ip rule add iif "$(ip -brief route get "$ROUTING_ST_IP" | awk '{print $3; exit}')" table "$TABLE_TO_GW"
ip rule add iif "$(ip -brief route get "$ROUTING_GW_IP" | awk '{print $3; exit}')" table "$TABLE_TO_ST"

# Enable ICMP between next hop and trunk
ip rule add from "$ROUTING_GW_IP" table "$TABLE_TO_GW"
ip rule add from "$ROUTING_ST_IP" table "$TABLE_TO_ST"

ip route add default via "$ROUTING_GW_NEXT_HOP" table "$TABLE_TO_GW" proto static
ip route add default via "$ROUTING_ST_NEXT_HOP" table "$TABLE_TO_ST" proto static
