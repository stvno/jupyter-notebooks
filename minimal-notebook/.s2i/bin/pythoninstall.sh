#!/bin/bash

########################################################################
# INFO: Install everything that's required for Jupyter notebooks here.
########################################################################

# Ensure we are using the latest pip and wheel packages.

pip install -U pip setuptools wheel

# Install mod_wsgi for use in optional webdav support.

pip install 'mod_wsgi==4.6.8'

# Install supervisord for managing multiple applications.

pip install 'supervisor==4.1.0'

#Install base packages needed for running Jupyter Notebooks. 

pip install -r /tmp/src/requirements.txt
