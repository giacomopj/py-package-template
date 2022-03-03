===================
py-package-template
===================

This is a template repository for Python packages.

The goal is to encapsulate a Python development ecosystem that encourages test-driven and continuous code integration with uniform style and type safety.

Python is an interpreted language. Building Python packages deos not necessarily involve compiling, which can be computationally intensive. Therefore, continuous integration can be carried out locally, either on a local machine or in a Docker container. In here, a pipeline goes automatically through a series of checks and unit tests before commiting or pushing code to the remote repository.

The build system orchestrates the several tools for continuous integration.

The development ecosystem in this repository comprises the following toolchain:

- The project dependencies are managed with *Poetry*
- The project Python version is managed with *Pyenv* (*)
- The code is linted with *Flake8*
- The code formatting is enforced with *Black*
- The code is unit-tested with *pytest*
- The code type safety is statically analysed with *MyPy* (**)
- Code documentation can be automatically generated with *Sphinx*
- Code checks above are hooked to every git commit
- Unit tests and test coverage checks are hooked to every git push
- The project is containerized with *Docker* and multi-stage builds
- The project IDE is *VS Code* pre-configured for the whole toolchain

(*) Not used in the Docker container, whose image is tied to the Python version passed as parameter (i.e., 3.10.2 by default)

(**) The pipeline is configured so that it does not break if the static checkers fails

Repository Setup
================

The following steps are to create a new repository from this template:

- Create a new empty repository named <mynewrepo> at </url/of/my/new/repo>

- Run the following commands to clone the template repository::

      git clone https://github.com/giacomopj/py-package-template.git <mynewrepo>

  * and keep the commit history::

        cd <mynewrepo>
        git remote set-url origin </url/of/my/new/repo>
        git push -u origin master

  * and cancel the commit history::

      cd <mynewrepo>
      git rm -rf .git
      git init .
      git remote set-url origin </url/of/my/new/repo>
      git add .
      git commit -m "First commit"
      git push -u origin master

Local Installation
==================

The following steps are to install the Python ecosystem on your local machine:

- Install Git

- Install Pyenv and one or more stable versions of Python with Pyenv

- Install Poetry

- Install VS Code with Pylance extension

- Setup the repository (see paragraph above)

- Set local Python version x.x.x::

      pyenv local x.x.x

- Use local Python version inside the virtual environment::

      poetry env use python

- Install all dependencies for the virtual environment::

      poetry install
      poetry update

- Activate the virtual environment::

      poetry shell

- Set pre-commit and pre-push hooks::

      pre-commit install -t pre-commit
      pre-commit install -t pre-push

- Run all code pre-commit checks (optional)::

      pre-commit run --all-files

- Run all unit tests and check test coverage (optional)::

      pytest
      pytest --cov --cov-fail-under=100

- Run VS Code from inside the virtual environment (optional)::

      code .
      
- Press "Local Runner" from Debug and Run to launch the application (optional)

References:

* https://cookiecutter-hypermodern-python.readthedocs.io/en/2020.11.15/guide.html#how-to-run-your-code
* https://mitelman.engineering/blog/python-best-practice/automating-python-best-practices-for-a-new-project/#why-run-checks-before-commit

Container Installation
======================

The following steps are to build the image of the devlopment ecosystem and run it inside one or more Docker containers:

- Install Git

- Install Docker

- Install VS Code with Pylance and Docker extensions

- Setup the repository (see paragraph above)

A Dockerfile is provided to assemble Docker image, which consists of three stages:

#. Debugger
#. Runner
#. Tester

The stages Debugger and Runner can be build and run into a Docker container from Debug and Run in VS Code:

- Press "Docker Runner" configuration to launch the application

- Press "Docker Debugger" configuration to debug the application

The stage Tester can be build and run into a Docker container from command line to launch the script /Scripts/start-up.sh (*)::

docker build --target=tester -t test-app .

(*) This script now performs all pre-commit and pre-push check, then launches the application and finally gives access to the container root shell

References:

* https://code.visualstudio.com/docs/remote/containers

Development
===========

To add a new dependency <newdependency> to the ecosystem::

      poetry add <newdependency>
      git add pyproject.toml
      git commit -m "Added <newdependency>"
      
Generating code documentation:

Folder Tree
===========

Files in the root directory are only for configuration.

Bin
---

This folder is meant to contain executable binary files.

Data
----

This folder is meant to contain data files.

Docs
----

This folder is meant to contain source code documentation.

Logs
----

This folder is meant to contain log files.

Plots
-----

This folder is meant to contain output plots.

Resources
---------

This folder is meant to contain relevant files such as:

- Images
- Spreadsheets
- Presentations
- Papers
- Datasheets
- Etc.

Scripts
-------

This folder is meant to contain scripts for:

- Generating plots
- Sorting data files
- Filtering log files
- Etc.

Src
---

This folder is meant to contain the source code of one or more modules or a package ore a library.

 > Python modules are executable .py scripts

 > A Python package

 * is a collection of modules organized in a folder
   that contains __init__.py
 * can be made of multiple sub-packages
 * can be made executable as a script by providing __main__.py
   which imports the package as a module

 > A Python library is a collection of packages

Tests
-----

This folder is meant to contain unit tests.

 > The tree of this folder shall mirror that of the source code
