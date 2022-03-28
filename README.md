# SigInt Package Template

This is a repository for the Python package template for Spire SigInt team.

The Dockerfile adds specific dependencies that might be useful in most of the team repositories.

## 1. Installation

For installation instructions refer to https://github.com/giacomopj/py-package-template

## 2. How To

- How to keep up-to-date with this template any branch <branchname> (e.g., master) of any repository based on this template

      git remote add template https://github.com/giacomopj/sigint-package-template.git
      git fetch --all
      git merge template/<branchname> --allow-unrelated-histories

  Merging the updates inevitably causes a number of conflicts (in README.md, pyproject.toml, etc.) that have to be resolved manually
