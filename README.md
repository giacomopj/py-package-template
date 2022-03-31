# SigInt Package Template

This is a repository for the Python package template for Spire SigInt team.

The Dockerfile adds specific dependencies that might be useful in most of the team repositories.

## 1. Installation

For installation instructions refer to https://github.com/giacomopj/py-package-template

The value configured for GIT_ACCESS_TOKEN in **/.vscode/setting.json** is set by default wih a shared Git access token. Optionally, this value can be replaced with the personal Git access token generated at https://github.com/settings/tokens

## 2. How To

- How to keep up-to-date with this template any branch <branchname> (e.g., master) of any repository based on this template

      git remote add template https://github.com/giacomopj/sigint-package-template.git
      git fetch --all
      git merge template/<branchname> --allow-unrelated-histories

  Merging the template updates inevitably causes a number of conflicts (in README.md, pyproject.toml, etc.) that have to be resolved manually one by one

## 3. Issues With Windows Host OS

If the host OS is Windows, VS Code could fail to build the Docker images from Run and Debug. To solve this issue, it might be necessary to implement the following workarounds:

- Manually replacing the environment variables GIT_ACCESS_TOKEN and WORKSPACE_PATH in **/.vscode/tasks.json** with the respective values, which are, respectively, the Git access token and the absolute path to the repository folder with the workspace (\*)
      
  (\*) In-built Command Prompt (CMD) or PowerShell (WSL) cannot expand the environment variables in **/.vscode/tasks.json**

- Manually converting the EOL formatting of .sh files in **/scripts** from CRLF to LF
