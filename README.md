# docker-manage-windows

An ansible management container for windows infrastructure.

## Create a `docker-compose.yml`

**NOTE**: the volumes mount should contain the playbook to be executed. The playbook must have a `site.yml` as starting point and a inventory file `production`.

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
      - MANAGEWINDOWS_CRON='0 0 * * *'
      - MANAGEWINDOWS_KDC='kdc'
```

## Environment Variables

###### MANAGEWINDOWS_DOMAIN

  - Specify the Domain. The script will use this value to create a valid `/etc/krb5.conf`

##### MANAGEWINDOWS_KDC

  - The Kerberos Domain Controller. At the moment KDC and the Management Server will be the same

##### MANAGEWINDOWS_CRON

  - Specify the intervals of execution for the playbook
  - **DEFAULT**: '0 0 * * *'