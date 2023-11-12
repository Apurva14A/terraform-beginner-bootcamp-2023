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

[Shebang Considerationsh](https://en.wikipedia.org/wiki/Shebang_(Unix))


## Execution Considerations


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

[Linux Permissions Considerations](https://www.redhat.com/sysadmin/linux-file-permissions-explained)


### Gitpod Lifecycle (Before, Init, Command)

We need to keep in mind before using Init -

[GitPod Lifecycle](https://www.gitpod.io/docs/configure/workspaces/workspace-lifecycle)


### Working Env Vars

We can list out all Environment Variables (Env Vars) using `env` command.

We can filter out specific env variables using grep e.g `env | grep GITPOD_`.


### Settings and Unsetting Env Vars

In the terminal we can set using `export PROJECT_ROOT=/workspace/terraform-beginner-bootcamp-2023`.

In the terminal we can unset using `unset PROJECT_ROOT`.

We can set an env vars temporarily when just running a command.

```sh
PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023' ./bin/path
```

Within a bash script we can set an env without writing export e.g.

```sh
PROJECT_ROOT=/workspace/terraform-beginner-bootcamp-2023

echo $PROJECT_ROOT
```

#### Printing Env Vars

We can print env var using echo e.g 'echo $PROJECT_ROOT'

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env var you set up on another windows.

If you want Env Vars persist to across all future bash terminal that are open you need to set env vars in your bash profile e.g `.bash_profile`

#### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by stroing them in Gitpod Secrets Storage.

```
gp env PROJECT_ROOT='/workspace/terraform-beginner-bootcamp-2023'
```
All future workspaces launched will set the env vars for all bash terminals open in thoes workspaces.

You can also set env in the `.gitpod.yml` but this can only contaiin non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for this project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli).

[Getting Started Install (AWS CLI)](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credential is configured correctly or not by exectuting the following AWS CLI command:
```sh
aws sts get-caller-identity
```
if it is successful you shoud see a json payload  return which looks like this:

```json
{
    "UserId": "AIDJHNBDBMSBDFK",
    "Account": "1234567891011",
    "Arn": "arn:aws:iam::1234567891011:user/terraform-beginner-bootcamp"
}

```

We'll need to generate AWS credentials from IAM inorder to use AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources thier providers and modules from the Terraform Registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will alllow too create resources in terraform.
- **Modules** are a way to refactor or to large amounts opf code modular, portable and sharable. 

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see the list of all the terraform command by typing `terraform` in the console.


#### Terraform Init

`terraform init` 
This command is the first command to be executed which downlaod the .terraform binaries into the workspace and further used in the projects.

#### Terraform Plan

`terraform plan`
This will generate a changesets, about our infrastructure and what will be changed.

We can output thsi changeset i.e 'plan' to be passed to apply command .Also, it is optional.

#### Terraform Apply

`terraform apply`
This will run a plan based on the changeset passed. Apply will create the infrastructure based on plan.Apply will prompt us 'yes or no'. If we can automatically apply then we have use `--auto-approve` as flag with apply.

### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used in this project.

The Terraform Locked File **should be commited** to your Version Control System(VCS) e.g 'Github'.

### Terraform state files

`terraform.tfstate` contains the current state of your infrastructure provisioned into the environment.

This file **should not be commited** into your Version Control System(VCS). As it, contains sensitive data and have more chances of getting modified which can be more disaterous. Losing the data of state file means loss of infrastructure.

`terraform.tfstate.backup` is the previous state of the infrastructure.

### Terraform Directory

`.terraform` contains the binaries of the terraform providers.



