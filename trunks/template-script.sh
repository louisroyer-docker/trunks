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

awk \
	-v NIC_ST="${NIC_ST}" \
	-v NIC_GW="${NIC_GW}" \
	-v BW_FORWARD="${BW_FORWARD}" \
	-v BW_RETURN="${BW_RETURN}" \
	-v DELAY_VALUE="${DELAY_VALUE}" \
	-v DELAY_OFFSET="${DELAY_OFFSET}" \
	-v ACM="${ACM_SUB}" \
	'{
		sub(/%NIC_ST/, NIC_ST);
		sub(/%NIC_GW/, NIC_GW);
		sub(/%BW_FORWARD/, BW_FORWARD);
		sub(/%BW_RETURN/, BW_RETURN);
		sub(/%DELAY_VALUE/, DELAY_VALUE);
		sub(/%DELAY_OFFSET/, DELAY_OFFSET);
		sub(/%ACM/, ACM);
		print;
	}' \
	"${CONFIG_TEMPLATE}" > "${CONFIG_FILE}"
