Insight-reloaded installer
==========================

Configure your server
---------------------

Open chef/solo.json to configure the global variables


Install chef-solo
-----------------
 
Run the provisionning with chef-solo::

    $ sudo ./scripts/chef-install
    $ sudo chef-solo -c ./chef/solo.rb

Then you can run insight-reloaded::

    $ sudo su insight
    $ cd /home/insight/insight
    $ bin/python setup.py install
    $ bin/circusd etc/circus/circus.ini

