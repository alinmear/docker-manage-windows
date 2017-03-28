#!/bin/bash

_playbook_root="/opt/manage-windows"
_playbook="${_playbook_root}/site.yml"
_inventory="${_playbook_root}/production"

echo $MANAGEWINDOWS_PASS | kinit $MANAGEWINDOWS_USER
ansible-playbook ${_playbook} -i ${_inventory}
