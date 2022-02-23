===================
py-package-template
===================

This is a template repository for Python packages.

Setup
=====

Setup.

Folder tree
===========

Files in the root directory are only for configuration.
The folders organize the rest of the files as follows.

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
