#!/bin/bash
set -e

# check if we should trust selfsigned certificates
if [ "$TRUST_SELFSIGN" -eq 1 ]; then
	echo "[INFO] TRUST_SELFSIGN is set to $TRUST_SELFSIGN, setting run parameter '--trust'" | ts '%Y-%m-%d %H:%M:%.S'
	SELFSIGN="--trust"
fi

# check if we should sync hidden files
if [ "$SYNC_HIDDEN" -eq 1 ]; then
	echo "[INFO] SYNC_HIDDEN is set to $SYNC_HIDDEN, setting run parameter '-h'" | ts '%Y-%m-%d %H:%M:%.S'
	SYNCHIDDEN='-h'
fi

# check if we should silence output
if [ "$SILENCE_OUTPUT" -eq 1 ]; then
	echo "[INFO] SILENCE_OUTPUT is set to $SILENCE_OUTPUT, setting run parameter '--silent'" | ts '%Y-%m-%d %H:%M:%.S'
	SILENCEOUTPUT='--silent'
fi

echo "[INFO] Running nextcloudcmd as following:" | ts '%Y-%m-%d %H:%M:%.S'
echo "[INFO] nextcloudcmd $SELFSIGN $SYNCHIDDEN $SILENCEOUTPUT -n --non-interactive /nextclouddata $NEXTCLOUD_PROTO://$NEXTCLOUD_SERVER$NEXTCLOUD_URLPATH$NEXTCLOUD_WEBDAV$NEXTCLOUD_FILEPATH" | ts '%Y-%m-%d %H:%M:%.S'
while true
do 
	su - nextcloudclient -c "nextcloudcmd $SELFSIGN $SYNCHIDDEN $SILENCEOUTPUT -n --non-interactive /nextclouddata $NEXTCLOUD_PROTO://$NEXTCLOUD_SERVER$NEXTCLOUD_URLPATH$NEXTCLOUD_WEBDAV$NEXTCLOUD_FILEPATH &> /opt/Nextcloud/log/latest.log"
	sleep $RUN_INTERVAL
done
