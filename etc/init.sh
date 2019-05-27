#!/bin/sh
set -e

# Timezone setting
if [ -n "${TZ}" ]; then
  echo "Set timezone to ${TZ}"
  echo "${TZ}" > /etc/timezone
  cp /usr/share/zoneinfo/"${TZ}" /etc/localtime
fi

# Config lockfile
if [ -f /config/.config-lock ]; then
  echo "Removing .config-lock"
  rm -f /config/.config-lock
fi

# Create logfile
mkdir -p /config/logs/
touch /config/logs/logfile.log

# Set User permissions
if [ -n "${PUID}" ] && [ -n "${PGID}" ]; then
  adduser -D -H -s /bin/sh -u ${PUID} flexget flexget
  chown -R "${PUID}":"${PGID}" /config
  chmod -R 775 /config
fi

# Set FLEXGET_WEB_PASS
if [[ ! -z "${FLEXGET_WEB_PASS}" ]]; then
  echo "Setting FLEXGET_WEB_PASS: ${FLEXGET_WEB_PASS}"
  flexget -c "/config/config.yml" \
    --logfile "/config/logs/logfile.log" \
    web passwd "${FLEXGET_WEB_PASS}"
fi

# Run flexget
if [ -n "${PUID}" ]; then
  echo "Starting Flexget..."
  su flexget -m -c \
    exec 'flexget -c "/config/config.yml" \
    --logfile "/config/logs/logfile.log" \
    --loglevel "${FLEXGET_LOG_LEVEL:-debug}" \
    daemon start --autoreload-config'
else
  echo "Flexget needs a PUID & PGID environment variable"
fi