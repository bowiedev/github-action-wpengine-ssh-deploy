#!/bin/sh -l

set -e

: ${WPE_ENV_NAME?Required environment name variable not set.}
: ${WPENGINE_SSHG_KEY_PRIVATE?Required secret not set.}
: ${WPENGINE_SSHG_KEY_PUBLIC?Required secret not set.}

SSH_PATH="$HOME/.ssh"
KNOWN_HOSTS_PATH="$SSH_PATH/known_hosts"
WPENGINE_SSHG_KEY_PRIVATE_PATH="$SSH_PATH/github_action"
WPENGINE_SSHG_KEY_PUBLIC_PATH="$SSH_PATH/github_action.pub"
WPENGINE_SSH_HOST="$WPE_ENV_NAME.ssh.wpengine.net"
WPE_DESTINATION="$WPE_ENV_NAME"@"$WPENGINE_SSH_HOST":sites/"$WPE_ENV_NAME"
#setting up our connection from GH action machine and
#making keys that will transfer from the site repo secrets to the action machine.

#calling out the full path of our WPE destination

mkdir "$SSH_PATH"

ssh-keyscan -t rsa "$WPENGINE_SSH_HOST" >> "$KNOWN_HOSTS_PATH"

echo "$WPENGINE_SSHG_KEY_PRIVATE" > "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
echo "$WPENGINE_SSHG_KEY_PUBLIC" > "$WPENGINE_SSHG_KEY_PUBLIC_PATH"

chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS_PATH"
chmod 600 "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
chmod 644 "$WPENGINE_SSHG_KEY_PUBLIC_PATH"

#dumping vars

ssh-keygen -E md5 -lf "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
echo WPE_ENV_NAME: "$WPE_ENV_NAME"
echo WPENGINE_SSH_HOST: "$WPENGINE_SSH_HOST"
echo WPE_DESTINATION: "$WPE_DESTINATION"
echo "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
ls -l "$WPENGINE_SSHG_KEY_PRIVATE_PATH"

rsync --rsh='ssh -p 22 -i $WPENGINE_SSHG_KEY_PRIVATE_PATH -o IdentitiesOnly=yes' -a --exclude 'node_modules' --exclude=".*" . selive@selive.ssh.wpengine.net:sites/selive/
