#!/bin/bash

# Check if the PGID exists, if not create the group with the name 'nextcloudclient'
grep $"${RUN_GID}:" /etc/group > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "[INFO] A group with PGID $RUN_GID already exists in /etc/group, nothing to do." | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[INFO] A group with PGID $RUN_GID does not exist, adding a group called 'nextcloudclient' with PGID $RUN_GID" | ts '%Y-%m-%d %H:%M:%.S'
	groupadd -g $RUN_GID nextcloudclient
fi

# Check if the PUID exists, if not create the user with the name 'nextcloudclient', with the correct group
grep $"${RUN_UID}:" /etc/passwd > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "[INFO] An user with PUID $RUN_UID already exists in /etc/passwd, nothing to do." | ts '%Y-%m-%d %H:%M:%.S'
else
	echo "[INFO] An user with PUID $RUN_UID does not exist, adding an user called 'nextcloudclient user' with PUID $RUN_UID" | ts '%Y-%m-%d %H:%M:%.S'
	useradd --comment "nextcloudclient user" --gid $RUN_GID --uid $RUN_UID --create-home --shell /bin/bash nextcloudclient
fi


netrc_file="/home/nextcloudclient/.netrc"
nextcloud_server_without_port=$(echo $NEXTCLOUD_SERVER | sed 's/\(.*\):.*/\1/')
cat <<EOF > $netrc_file
machine $nextcloud_server_without_port
	login $NEXTCLOUD_USER
	password $NEXTCLOUD_PASS
EOF
chown $RUN_UID:$RUN_GID $netrc_file
chmod 600 $netrc_file

echo "[INFO] Chaning ownership of all files and directories in /nextclouddata and /opt/Nextcloud/log to $RUN_UID:$RUN_GID" | ts '%Y-%m-%d %H:%M:%.S'
chown -R $RUN_UID:$RUN_GID /nextclouddata /opt/Nextcloud/log

exec $@
