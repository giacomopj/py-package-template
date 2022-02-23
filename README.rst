===================
py-package-template
===================

This is a template repository for Python packages.

The goal is to have a Python development ecosystem that following best practices:

- is modern
- test-driven
- enforces
- commit-safe
- pre-configuration for VS Code

Requirements
============

- Install *pyenv* (Python version manager)
- Install one or more stable versions of Python with pyenv
- Install *Poetry* (Python dependency manager)
- Install *VS Code* (IDE)
- Install Pylance extension inside VS Code

Setup
=====

- Clone this repository
- Change working directory to the clone resository
- Set local Python version
  ``pyenv local 3.10.x``
- Use local Python version inside the virtual environment
  ``poetry env use python``
- Install all dependencies for the virtual environment
  ``poetry install``
- Activate the virtual environment
  ``poetry shell``
- Run VS Code from inside the virtual environment
  ``code .``
  
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

This folder is intended to contain log files.

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

This folder is meant to contain the source code of:

- Modules
- One package (see template)
- One library

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
