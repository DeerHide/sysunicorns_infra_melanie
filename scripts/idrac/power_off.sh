#!/usr/bin/env bash

# Load environment variables from .env file if it exists
if [[ -f .env ]]; then
  export $(cat .env | xargs)
fi

IDRAC_HOSTS=(
    "192.168.5.10" # idrac-c6100-s01.host
    "192.168.5.11" # idrac-c6100-s02.host
    "192.168.5.12" # idrac-c6100-s03.host
    "192.168.5.13" # idrac-c6100-s04.host
    "192.168.5.14" # idrac-r610-5BF035J.host
    "192.168.5.15" # idrac-r310-FSGMD5J.host
    "192.168.5.16" # idrac-r310-5L4BS4J.host
    "192.168.5.17" # idrac-r310-BSGMD5J.host
)

if [[ -z "$IDRAC_USER" || -z "$IDRAC_PASSWORD" ]]; then
    echo "Please set IDRAC_USER and IDRAC_PASSWORD in your environment."
    exit 1
fi

for IDRAC_HOST in "${IDRAC_HOSTS[@]}"; do
    echo "Testing $IDRAC_HOST"
    ipmitool -I lanplus -H $IDRAC_HOST -U $IDRAC_USER -P $IDRAC_PASSWORD power off
done
