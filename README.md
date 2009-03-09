Cyrus user map for Postfix
==========================

This program creates a **Postfix** map table listing all valid email **Cyrus Imap**
user accounts available in the Cyrus Imap database.

This script works both with or without Cyrus Imap's Virtual Domain
feature.

The map uses the Postfix *hash* format by default.


USAGE
-----

Execute this script periodically with *cron*, under the *root* user.
It will create a user map of all the valid Cyrus Imap accounts. There is
not need to restart Postfix.

PREREQUISITES
-------------

Both **Postfix** and **Cyrus Imap** must be running locally.

CONFIGURATION
-------------

1) Edit the configuration section of the script:

* Set `USERS_MAPFILE` to the map's full path, usually in `/etc/postfix`.
* Set `CYRUS_CMD` to Cyrus' `ctl_mboxlist` command's full path (`/usr/sbin/ctl_mboxlist`
  on Debian Linux).

2) Copy the script into the server's PATH.

3) Add or modify the following line in Postfix's `/etc/postfix/main.cf`:

    local_recipient_maps = hash:/etc/postfix/cyrus_usermap $alias_maps

and reload the postfix configuration :

    postfix reload

3) Periodically execute the script via cron.

* If you're running a modern cron, like Linux's cron, copy the file
  `cron/create_cyrus_user_map` to `/etc/cron.d`.
* Otherwise adapt the cron file to you system in order to run the script
  periodically.
* Don't forget to change the script's path if you're not installing it in
  `/usr/local/sbin`.

4) Enjoy.


BUGS
----

None known.

And yes, this is really a Ruby script for a sysadmin task, it's not a bug, it's a feature.

AUTHOR
------

* Copyright (C) 2009 [Farzad FARID](mailto:ffarid@pragmatic-source.com), [Pragmatic Source](http://www.pragmatic-source.com/)

Contact me if you have questions to ask or bug reports to make.

REFERENCES
----------

* [GitHub project](http://github.com/Farzy/cyrus-user-map/)
* [Rejecting Unknown Local Recipients with Postfix](http://www.postfix.org/LOCAL_RECIPIENT_README.html)
* [Cyrus Imap Virtual Domains](http://cyrusimap.web.cmu.edu/imapd/install-virtdomains.html)

LICENSE
-------

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

Please check the `LICENSE` file for a full copy of the GPL 3 license.
