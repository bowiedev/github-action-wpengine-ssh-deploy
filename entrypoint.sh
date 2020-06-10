#!/bin/sh -l

set -e

: ${WPE_ENV_NAME?Required environment name variable not set.}
: ${WPENGINE_SSHG_KEY_PRIVATE?Required secret not set.}
: ${WPENGINE_SSHG_KEY_PUBLIC?Required secret not set.}

#SSH Key Vars 
SSH_PATH="$HOME/.ssh"
KNOWN_HOSTS_PATH="$SSH_PATH/known_hosts"
WPENGINE_SSHG_KEY_PRIVATE_PATH="$SSH_PATH/github_action"
WPENGINE_SSHG_KEY_PUBLIC_PATH="$SSH_PATH/github_action.pub"

#Deploy Vars
WPENGINE_SSH_HOST="$WPE_ENV_NAME.ssh.wpengine.net"
WPE_DESTINATION="$WPE_ENV_NAME"@"$WPENGINE_SSH_HOST":sites/"$WPE_ENV_NAME"

# Setup our SSH Connection & use keys
mkdir "$SSH_PATH"
ssh-keyscan -t rsa "$WPENGINE_SSH_HOST" >> "$KNOWN_HOSTS_PATH"

#Copy Secret Keys to container
echo "$WPENGINE_SSHG_KEY_PRIVATE" > "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
echo "$WPENGINE_SSHG_KEY_PUBLIC" > "$WPENGINE_SSHG_KEY_PUBLIC_PATH"

#Set Key Perms 
chmod 700 "$SSH_PATH"
chmod 644 "$KNOWN_HOSTS_PATH"
chmod 600 "$WPENGINE_SSHG_KEY_PRIVATE_PATH"
chmod 644 "$WPENGINE_SSHG_KEY_PUBLIC_PATH"

# Deploy via SSH
rsync --rsh="ssh -v -p 22 -i ${WPENGINE_SSHG_KEY_PRIVATE_PATH} -o StrictHostKeyChecking=no" -a --out-format="%n"  --exclude=".*" . "$WPE_DESTINATION"/