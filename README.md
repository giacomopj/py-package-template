# SigInt Package Template

This is a repository for the Python package template for Spire SigInt team.

The Dockerfile adds specific dependencies that might be useful in most of the team repositories.

## 1. Installation

For installation instructions refer to https://github.com/giacomopj/py-package-template

## 2. Git Access Token

The value configured for GIT_ACCESS_TOKEN in **/.vscode/setting.json** is set by default to a shared Git access token. Optionally, this value may be replaced with a personal Git access token, which can be generated at https://github.com/settings/tokens

## 3. How To

- How to keep up-to-date with this template any branch *branchname* (e.g., master) of any repository based on this template:

      git remote add template https://github.com/giacomopj/sigint-package-template.git
      git fetch --all
      git merge template/*branchname* --allow-unrelated-histories

  At the first time, merging the template updates inevitably causes a number of conflicts (in README.md, pyproject.toml, etc.) that have to be resolved manually one by one 
      
- How to add a line in the Dockerfile for the Base image in order to add a new dependency from a private Spire nsat repository *myrepository*:
      
      RUN poetry add git+https://${GIT_ACCESS_TOKEN}@github.com/nsat/*myrepository*.git -vvv
      
  Repositories of nsat currently added to the Base image:
  * tlegen
  * pypredict

## 4. Issues With Windows Host OS

VS Code is pre-configured to automatically send commands to Docker and this configuration works well in Linux and MacOS. On the contrary, VS Code fails to build the Docker images from Run and Debug menu if the host OS is Windows (\*). To solve this issue, it is necessary to launch **/.vscode/fix_tasks_env_var_windows.ps1** from PowerShell

(\*) In-built Command Prompt (CMD) or PowerShell (WSL) cannot expand the environment variables in **/.vscode/tasks.json**
