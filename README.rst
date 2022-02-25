===================
py-package-template
===================

This is a template repository for Python packages.

It integrates a toolchain to implement a few best practices:

- The project has its own virtual environment with specific dependencies fixed with *Poetry*
- The project uses a local Python version fixed with *Pyenv*
- The code is linted with *Flake8*
- The code formatting is enforced with *Black*
- The code is unit-tested with *pytest*
- The code static-type safety is ensured with *MyPy*
- Code checks are hooked to every git commit
- Unit tests and test coverage check are hooked to every git push
- The project IDE is *VS Code* pre-configured for the toolchain

The goal is to encapsulate a Python ecosystem that encourages test-driven development with uniform style while minimizing bugs.

Requirements
============

- Install Git
- Install Pyenv
- Install one or more stable versions of Python with Pyenv
- Install Poetry
- Install VS Code
- Install Pylance extension inside VS Code

Setup
=====

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

- Set local Python version::

      pyenv local 3.10.x
  
- Use local Python version inside the virtual environment::

      poetry env use python
  
- Install all dependencies for the virtual environment::

      poetry install
  
- Activate the virtual environment::

      poetry shell``
  
- Set pre-commit and pre-push hooks::

      pipenv run pre-commit install -t pre-commit
      pipenv run pre-commit install -t pre-push
  
- Run all code pre-commit checks::

      pre-commit run --all-files
  
- Run all unit tests and check test coverage::

      pytest --cov --cov-fail-under=100
  
- Run VS Code from inside the virtual environment::

      code .
  
References:

* https://cookiecutter-hypermodern-python.readthedocs.io/en/2020.11.15/guide.html#how-to-run-your-code
* https://mitelman.engineering/blog/python-best-practice/automating-python-best-practices-for-a-new-project/#why-run-checks-before-commit

Folder tree
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

.. note::
   Python modules are executable .py scripts

   A Python package

   * is a collection of modules organized in a folder
     that contains __init__.py
   * can be made of multiple sub-packages
   * can be made executable as a script by providing __main__.py
     which imports the package as a module

   A Python library is a collection of packages

Tests
-----

This folder is meant to contain unit tests.

.. note::
   The tree of this folder shall reflect that of the source code
