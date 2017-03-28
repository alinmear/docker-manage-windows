#!/bin/bash

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

crontab -l | grep -E "execute_playbook"
[[ $? == 1 ]] && (crontab -l 2>/dev/null; echo "$(remove_quotes "$MANAGEWINDOWS_CRON") execute_playbook 2>&1") | crontab -

# startup supervisord from Docker cmd
"$@"
