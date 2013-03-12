# Backup of echidna hosts configuration

## Overview

...if you make a change to an echidna1 configuration file, please add it to the list of FILES that need to be backed up.

HOWEVER, DO NOT ADD PASSWORDS OR CERTIFICATES.

## Usage

* git clone this project into your account on the host
* modify FILES to add the text configuration files that are locally modified
* run ./backup.sh
* git commit the files
* git push


