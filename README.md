# GitHub Action for WP Engine Git Deployments

An action to deploy your repository to a **[WP Engine](https://wpengine.com)** site via git. [Read more](https://wpengine.com/git/) about WP Engine's git deployment support.

## Example GitHub Action workflow

```
name: Deploy to WP Engine
  
push:
    branches:
      - master

jobs:
  build:

    runs-on: ubuntu-latest
        
    steps: 
    - uses: actions/checkout@v2
    - name: SSH Deploy to WP Engine
      uses: bowiedev/github-action-wpengine-ssh-deploy@master 
      env: 
          WPE_ENV_NAME: <YOUR INSTALL NAME> 
          WPENGINE_SSHG_KEY_PUBLIC: ${{ secrets.PUBLIC_KEY_NAME }} 
          WPENGINE_SSHG_KEY_PRIVATE: ${{ secrets.PRIVATE_KEY_NAME }} 

```

## Environment Variables & Secrets

### Required

| Name | Type | Usage |
|-|-|-|
| `WPE_ENV_NAME` | Environment Variable | Insert the name of the WP Engine environment you want to deploy to. |
| `WPENGINE_SSHG_KEY_PRIVATE` | Secret | Private SSH Key for the SSH Gateway and deployment. See below for SSH key usage. |
|  `WPENGINE_SSHG_KEY_PUBLIC` | Secret | Public SSH Key for the SSH Gateway and deployment. See below for SSH key usage. |


### Further reading

* [Defining environment variables in GitHub Actions](https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#environment-variables)
* [Storing secrets in GitHub repositories](https://developer.github.com/actions/managing-workflows/storing-secrets/)

## Setting up your SSH keys for repo

1. [Generate a new SSH key pair](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) as a special deploy key between your Github Repo and WP Engine. The simplest method is to generate a key pair with a blank passphrase, which creates an unencrypted private key. 

2. Store your public and private keys in the GitHub repository if your website as new 'Secrets' (under your repository settings) using the names `PRIVATE_KEY_NAME` and `PUBLIC_KEY_NAME` respectively with the name in your specfic files. These can be customized, just remember to change the var in the yml file to call them correctly. 

3. Add the .pub SSH key to your WP Engine SSH Gateway configuration. https://wpengine.com/support/ssh-gateway/#addsshkey

## Add Workflow to your Repo

1. Navigate to https://github.com/YOUR_REPO
2. Actions Tab 
3. Select "Skip this and set up a workflow yourself ->"
4. Copy and Paste the above sample into the main.yml (replacing the desired install name)
5. Commit the yml file to your repo