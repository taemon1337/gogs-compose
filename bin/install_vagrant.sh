#!/bin/bash

# Set Version
version="1.9.4"
package="vagrant_$version""_x86_64.deb"
download_link="https://releases.hashicorp.com/vagrant/$version/$package"

_download () {
  wget $download_link
}

_install () {
  if [ -r $package ]; then
    apt install ./$package
    vagrant -v
  else
    echo "No package found to install at ./$package"
  fi
}

_main () {
  if [ -r $package ]; then
    _install
  else
    _download
    _install
  fi
}

_main


