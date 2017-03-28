#!/bin/bash

_playbook_root="/opt/manage-windows"
_playbook="${_playbook_root}/site.yml"
_inventory="${_playbook_root}/production"

remove_quotes() {
    expr="$1"
    expr="${expr%\'}"
    expr="${expr#\'}"
    echo "$expr"
}

setup_krb5() {
    sed -i -e "s|^#||g" \
	   -e "s|EXAMPLE.COM|${MANAGEWINDOWS_DOMAIN^^}|g" \
           -e "s|example.com|${MANAGEWINDOWS_DOMAIN,,}|g" \
	   -e "s|kerberos\.|${MANAGEWINDOWS_KDC,,}\.|g" \
	   /etc/krb5.conf 
    }

setup_krb5

crontab -l | grep -E "ansible-playbook|\/opt\/manager-windows\/site\.yml"
[[ $? == 1 ]] && (crontab -l 2>/dev/null; echo "$(remove_quotes "$MANAGEWINDOWS_CRON") ansible-playbook ${_playbook} -i ${_inventory} ") | crontab -

# startup supervisord from Docker cmd
"$@"
