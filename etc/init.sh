#!/bin/sh
set -e

# Config lockfile
if [ -f /config/.config-lock ]; then
  echo "Removing .config-lock"
  rm -f /config/.config-lock
fi

# Set FLEXGET_WEB_PASS
if [[ ! -z "${FLEXGET_WEB_PASS}" ]]; then
  echo "Setting FLEXGET_WEB_PASS: ${FLEXGET_WEB_PASS}"
  flexget web passwd "${FLEXGET_WEB_PASS}"
fi

# Create logfile
mkdir -p /config/logs/
touch /config/logs/logfile.log

# Run flexget
flexget -c "/config/config.yml" \
  --logfile "/config/logs/logfile.log" \
  --loglevel "${FLEXGET_LOG_LEVEL:-debug}" \
  daemon start --autoreload-config