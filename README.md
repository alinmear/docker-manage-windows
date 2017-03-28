# docker-manage-windows

An ansible management container for windows infrastructure.

## Create a `docker-compose.yml`

**NOTE**: the volumes mount should contain the playbook to be executed. The playbook must have a `site.yml` as starting point and an inventory file `production`. For more informations about ansible and windows take a look at http://docs.ansible.com/ansible/intro_windows.html .

```yaml
version: '2'

services:
  manage:
    image: alinmear/docker-manage-windows
    container_name: manage-windows
    volumes:
      - ./playbook:/opt/manage-windows
    dns:
      - 8.8.8.8
    dns_search:
      - example.com
    environment:
      - MANAGEWINDOWS_DOMAIN=example.com
      - MANAGEWINDOWS_USER=administrator
      - MANAGEWINDOWS_PASS=mypass
      - MANAGEWINDOWS_CRON='0 0 * * *'
      - MANAGEWINDOWS_KDC='kdc'
```

## Deploy to remote docker host

For this use the deploy playbook.

**NOTE**: Edit deploy.yml first, to set the domain infos at the vars section.

```bash
ansible-playbook deploy.yml -i '<host>,'
```

## Environment Variables

##### MANAGEWINDOWS_DOMAIN

  - Specify the Domain. The script will use this value to create a valid `/etc/krb5.conf`

##### MANAGEWINDOWS_USER

  - Specify the User for Kerberos TGT

##### MANAGEWINDOWS_PASS

  - Specify the Pass for Kerberos TGT

##### MANAGEWINDOWS_KDC

  - The Kerberos Domain Controller. At the moment KDC and the Management Server will be the same

##### MANAGEWINDOWS_CRON

  - Specify the intervals of execution for the playbook
  - **DEFAULT**: '0 0 * * *'
