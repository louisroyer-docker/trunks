#!/usr/bin/env bash
# Copyright 2024 Louis Royer. All rights reserved.
# Use of this source code is governed by a MIT-style license that can be
# found in the LICENSE file.
# SPDX-License-Identifier: MIT

set -e
if [ -z "$NIC_ST" ]; then
	echo "Missing mandatory environment variable (NIC_ST)." > /dev/stderr
	exit 1
fi
if [ -z "$NIC_GW" ]; then
	echo "Missing mandatory environment variable (NIC_GW)." > /dev/stderr
	exit 1
fi
if [ -z "$BW_FORWARD" ]; then
	echo "Missing mandatory environment variable (BW_FORWARD)." > /dev/stderr
	exit 1
fi
if [ -z "$BW_RETURN" ]; then
	echo "Missing mandatory environment variable (BW_RETURN)." > /dev/stderr
	exit 1
fi
if [ -z "$DELAY_VALUE" ]; then
	echo "Missing mandatory environment variable (DELAY_VALUE)." > /dev/stderr
	exit 1
fi
if [ -z "$DELAY_OFFSET" ]; then
	echo "Missing mandatory environment variable (DELAY_OFFSET)." > /dev/stderr
	exit 1
fi

# ACM
IFS=$'\n'
ACM_SUB=""
for ACM_L in ${ACM}; do
	if [ -n "${ACM_L}" ]; then
		ACM_SUB="${ACM_SUB}\n  ${ACM_L}"
	fi
done


sed \
	-e "s/%NIC_ST/${NIC_ST}/g" \
	-e "s/%NIC_GW/${NIC_GW}/g" \
	-e "s/%BW_FORWARD/${BW_FORWARD}/g" \
	-e "s/%BW_RETURN/${BW_RETURN}/g" \
	-e "s/%DELAY_VALUE/${DELAY_VALUE}/g" \
	-e "s/%DELAY_OFFSET/${DELAY_OFFSET}/g" \
	-e "s/%ACM/${ACM_SUB}/g" \
"${CONFIG_TEMPLATE}" > "${CONFIG_FILE}"
