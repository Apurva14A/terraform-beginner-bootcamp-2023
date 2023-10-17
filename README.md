# Terraform Beginner Bootcamp 2023

## Semantic Versoning :mage:

This project is going to utilize semantic versioning for its tagging.
[semver.org](https://semver.org/)


The general format:

**MAJOR.MINOR.PATCH**,e.g `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes

The Terraform CLI installations instructions have changed due to gpg keyring changes. So, we needed refer to the latest install CLI instructions via Terraform Documentationand change the scripting for install.

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

### Refactoring into Bash scripts

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. so we decided to create a bash script to install Terraform CLI.

This script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task file ([.gitpod.yml](.gitpod.yml))
- This allow us an easier to debug and execute manually Terraform CLI install.
- This will allow better portability for other

## Considerations for Linux Distribution

This project is build against Ubuntu.
Please consider checking Linux Distribution and change according to your distribution needs.

[How to check OS version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy

```

### Shebang Considerations

A Shebang (Pronounced she-bang) tells the bash script what program will interpret the script. e.g-   `#!/bin/bash`


ChatGPT we used has recommend us to use : `#!/env/bin/env bash`

- for portability different OS distributions

- Will search the user's PATH for the bash executable.

https://en.wikipedia.org/wiki/Shebang_(Unix)


##  Execution Considerations


When executing the bashs scripts we can use `./` shorthand noatations.

e.g- `./bin/install_terraform_cli`

If we are using a script in gitpod.yml we need to point the script to a program to interpret it.

e.g- `source ./bin/install_terraform_cli`

### Linux permissions Considerations

In order to make our bash script executables we need to change the file permissions to be executable.

`chmod u+x ./bin/install_terrafoorm_cli`

Alternatively

```
chmod 744 ./bin/install_terraform_cli
```

https://www.redhat.com/sysadmin/linux-file-permissions-explained


### Gitpod Lifecycle (Before, Init, Command)

We need to keep in mind before using Init -

https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle