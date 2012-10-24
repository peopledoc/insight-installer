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

Then you can launch the circusd as a service_::

    $ sudo /etc/init.d/circusd start
    $ sudo /etc/init.d/circusd status
    $ sudo /etc/init.d/circusd stop
