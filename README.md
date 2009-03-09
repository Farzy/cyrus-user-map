Cyrus user map for Postfix
==========================

This program creates a *Postfix* map table listing all valid email *Cyrus Imap* 
user accounts available in the Cyrus Imap database.

The map uses the Postfix "hash" format by default.


USAGE
-----

Execute this script periodically with "cron", under the "root" user.
It will create a user map of all the valid Cyrus Imap accounts. There is
not need to restart Postfix.

This script works both with or without Cyrus Imap's Virtual Domain
feature.

CONFIGURATION
-------------

1) Edit the configuration section of the script:

* Set `USERS_MAPFILE` to the map's full path, usually in `/etc/postfix`.
* Set `CYRUS_CMD` to Cyrus' ctl_mboxlist command's full path (/usr/sbin/ctl_mboxlist)
  on Debian Linux.

2) Add the following line to Postfix's /etc/postfix/main.cf:

    local_recipient_maps = hash:/etc/postfix/cyrus_users_map

If you're running a modern cron, like Linux's cron, copyt the file
`cron/create_cyrus_user_map` to `/etc/cron.d`. Otherwise adapt the
cron file to you system in order to run the script periodically.


3) Enjoy.


AUTHOR
------

* [Farzad FARID](mailto:ffarid@pragmatic-source.com), [Pragmatic Source](http://www.pragmatic-source.com/)

REFERENCES
----------

* GitHub project
* [Rejecting Unknown Local Recipients with Postfix](http://www.postfix.org/LOCAL_RECIPIENT_README.html)

