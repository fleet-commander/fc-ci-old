#!/bin/bash
# Copyright (C) 2016 Red Hat, Inc.
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the licence, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with this program; if not, see <http://www.gnu.org/licenses/>.
#
# Author: Oliver Gutiérrez <ogutierrez@redhat.com>

INVENTORY_FILE=.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory

if [ -z $1 ]; then
    BRANCH="master"
else
    BRANCH=$1
fi

echo "##########################################################################"
echo "# Bringing up machines"
echo "##########################################################################"
vagrant up

# Building fleet commander
./build.sh $BRANCH

# Installing fleet commander in admin machine
./install.sh

echo "##########################################################################"
echo "# Finshed. Connect to http://$(cat $INVENTORY_FILE | grep admin | cut -d ' ' -f2 | cut -d'=' -f2):8008"
echo "##########################################################################"
