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

cd /config

# Set User permissions
if [ -n "${PUID}" ] && [ -n "${PGID}" ]; then
  if [ -z "$(getent passwd flexget)" ]; then
    adduser -D -s /bin/sh -u ${PUID} flexget flexget
  else
    usermod -u "${PUID}" flexget
    groupmod -g "${PGID}" flexget
  fi

  chown -R "${PUID}":"${PGID}" /config
  chmod -R 775 /config
fi

# Set FLEXGET_WEB_PASS
if [[ ! -z "${FLEXGET_WEB_PASS}" ]]; then
  echo "Setting FLEXGET_WEB_PASS"
  flexget -c "/config/config.yml" \
    --logfile "/config/logs/logfile.log" \
    web passwd "${FLEXGET_WEB_PASS}"
fi

# Run flexget
echo "Starting Flexget..."
flexget -c "/config/config.yml" \
  --logfile "/config/logs/logfile.log" \
  --loglevel "${FLEXGET_LOG_LEVEL:-debug}" \
  daemon start --autoreload-config