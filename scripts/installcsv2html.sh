#!/bin/bash
sudo apt-get install python-setuptools
git clone https://github.com/dbohdan/csv2html.git

chmod +x csv2html/setup.py
sudo python csv2html/setup.py install
sudo rm -rf csv2html
