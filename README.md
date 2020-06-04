# GitHub Action for WP Engine Git Deployments

An action to deploy your repository to a **[WP Engine](https://wpengine.com)** site via git. [Read more](https://wpengine.com/git/) about WP Engine's git deployment support.

## Example GitHub Action workflow

```
name: Deploy to WP Engine
  
on: [push]

jobs:
  build:

    runs-on: ubuntu-latest
        
    steps: 
    - uses: actions/checkout@v2
    - name: SSH Deploy to WP Engine
      uses: bowiedev/github-action-wpengine-ssh-deploy@master 
      env: 
          WPE_ENV_NAME: <YOUR INSTALL NAME>
          WPENGINE_SSHG_KEY_PUBLIC: ${{ secrets.WPENGINE_SSH_KEY_PUBLIC }}
          WPENGINE_SSHG_KEY_PRIVATE: ${{ secrets.WPENGINE_SSH_KEY_PRIVATE }}

```

## Environment Variables & Secrets

### Required

| Name | Type | Usage |
|-|-|-|
| `WPE_ENV_NAME` | Environment Variable | The name of the WP Engine environment you want to deploy to. |
| `WPENGINE_SSHG_KEY_PRIVATE` | Secret | Private SSH Key for the SSH Gateway and deployment. See below for SSH key usage. |
|  `WPENGINE_SSHG_KEY_PUBLIC` | Secret | Public SSH Key for the SSH Gateway and deployment. See below for SSH key usage. |

### Optional

| Name | Type  | Usage |
|-|-|-|
| `WPE_ENV_NAME` | Environment Variable  | This should allow you to use the name of any install in your account you would like to deploy to. |

### Further reading

* [Defining environment variables in GitHub Actions](https://developer.github.com/actions/creating-github-actions/accessing-the-runtime-environment/#environment-variables)
* [Storing secrets in GitHub repositories](https://developer.github.com/actions/managing-workflows/storing-secrets/)

## Setting up your SSH keys

1. [Generate a new SSH key pair](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) as a special deploy key. The simplest method is to generate a key pair with a blank passphrase, which creates an unencrypted private key.

2. Store your public and private keys in the GitHub repository if your website as new 'Secrets' (under your repository settings), using the names `WPENGINE_SSHG_KEY_PRIVATE` and `WPENGINE_SSHG_KEY_PUBLIC` respectively. These SSH Key Names are specific to the action config. 

3. Add the public key to your target WP Engine SSH Key settings - https://wpengine.com/support/ssh-keys-for-shell-access/ 
