[![Test Coverage](https://codeclimate.com/github/factor-io/connector-tutum/badges/coverage.svg)](https://codeclimate.com/github/factor-io/connector-tutum)
[![Dependency Status](https://gemnasium.com/factor-io/connector-tutum.svg)](https://gemnasium.com/factor-io/connector-tutum)
[![Build Status](https://travis-ci.org/factor-io/connector-tutum.svg?branch=rework)](https://travis-ci.org/factor-io/connector-tutum)
[![Gem Version](https://badge.fury.io/rb/factor-connector-tutum.svg)](http://badge.fury.io/rb/factor-connector-tutum)

Tutum Connector for Factor.io
======================

This gem provides Tutum actions through your Factor.io workflow. It was built with the [factor-connector-api](https://github.com/factor-io/connector-api) gem.

#Authentication

In order to make requests, you must obtain your [API key](https://dashboard.tutum.co/account/). Log into Tutum, click on the menu on the upper right corner of the page and click `Account info`. You should then see the `Api Key` selection.

#Functionality

###Services
• list all services<br />
• get a service's details<br />
• get a service's logs<br />

###Containers
• list all containers<br />
• get a container's details<br />

###Node Clusters
• list all clusters<br />
• get a cluster's details<br />
• create a cluster<br />

###Nodes
• list all nodes<br />
• get a node's details<br />

#Testing

Using your terminal to test locally, you must set up two environmental variables.
	
	$ export TUTUM_USERNAME=<username>
	$ export TUTUM_API_KEY=<api_key>

Then, you can bundle and run the tests.

	$ bundle exec rake

#Contributing

Documentation, feature requests, code, tests, and bug reports are welcomed. Click [here](https://github.com/factor-io/factor/wiki/Contribution) for more information.