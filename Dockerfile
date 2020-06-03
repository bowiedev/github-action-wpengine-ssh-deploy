FROM appleboy/drone-ssh:1.6.0-linux-amd64

LABEL "com.github.actions.name"="GitHub Action for WP Engine SSH Gateway Deployment"
LABEL "com.github.actions.description"="An action to deploy your repository to WP Engine via the SSH Gateway"
LABEL "com.github.actions.icon"="chevrons-up"
LABEL "com.github.actions.color"="blue"

LABEL "repository"="http://github.com/boweidev/github-action-wpengine-ssh-deploy"
LABEL "maintainer"="Alex Zuniga <alex.zuniga@wpengine.com>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
