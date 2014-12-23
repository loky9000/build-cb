[![Build Status](https://travis-ci.org/qubell-bazaar/cookbook-qubell-build.png?branch=master)](https://travis-ci.org/qubell-bazaar/cookbook-qubell-build)

Build Cookbook
==============
Cookbook for building Petclinic from git source with maven

Platform
--------
- Ubuntu 10.04, 12.04 (x32/x64)
- CentOS 5, 6 (x64)

Cookbooks
---------
- depends "apt"
- depends "build-essential", "1.4.2"
- depends "chef_handler", "1.1.4"
- depends "git", "2.7.1"
- depends "java", "1.11.7"
- depends "yum", "2.3.1"
