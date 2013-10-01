# Overview

` clojureweb-chef` - chef recipes for setting up a server for Clojure deployment.

## Project maturity

This project was born during [Clojure Cup 2013](http://clojurecup.com) and right now I don't know anybody who use it in production, so you can be the first ;)

## Prepare local environment

* Preferred way to use is to clone this repo and customize for your project
  `git clone git://github.com/juggler/clojureweb-chef.git --origin upstream APPLICATION-NAME-chef`
* Bootstrap local environment with `script/bootstrap`

## Prepare server

* Setup key based authentication to the target host (e.g. `ssh-copy-id` - `brew install ssh-copy-id`)
* Prepare target server with `script/prepare root@HOSTNAME`
* Customize `nodes/HOSTNAME.json` based on [nodes/default.json](https://github.com/juggler/clojureweb-chef/tree/master/nodes/default.json)
* Apply configuration to target host with `script/cook user@HOSTNAME`

## Scripts

There are 3 scripts to automate cooking process:

* `script/bootstrap` will install `librarian-chef` and `knife-solo` gems
* `script/prepare` will download cookbooks and install Chef on target node
* `script/cook` will apply recipes to the target node (you can re-run this script if you will add a new recipe or change an existing one)

## What's in the box

- `deployer` user with key-based ssh authentication (you have to rename [user.json.example](https://github.com/juggler/clojureweb-chef/tree/master/data_bags/deployer_authorized_keys/user.json.example) to `user.json` and add your public key)
- latest stable leiningen (based on [this](https://github.com/juggler/chef-leiningen) cookbook)
- openjdk 7
- nginx which will serve static files/pages, cache content and will act as a reverse proxy for your app server (you should read [this](http://juxt.pro/articles/manual-clojure-deployment.html?sect=9) article by JUXT team)

## Continue with Capistrano

Checkout this [deploy.rb](https://github.com/juggler/clojureweb-chef-demoapp/tree/master/config/deploy.rb)

## TODO:

* do not use `flatstack[rails]` cookbook because it just includes nginx

# Credits

This application is based on [chef-solo](http://docs.opscode.com/chef_solo.html) and [Flatstack's Rails Chef recipes](https://github.com/fs/chef-rails-cookbooks).
Check them out for default attributes.

# Authors

* [Max Prokopiev](http://maxprokopiev.com)
* Based on [rails3-base-chef](https://github.com/fs/rails3-base-chef) template.

# License

MIT
