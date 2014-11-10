[![Test Coverage](https://codeclimate.com/github/factor-io/connector-tutum/badges/coverage.svg)](https://codeclimate.com/github/factor-io/connector-tutum)
[![Dependency Status](https://gemnasium.com/factor-io/connector-tutum.svg)](https://gemnasium.com/factor-io/connector-tutum)
[![Build Status](https://travis-ci.org/factor-io/connector-tutum.svg?branch=rework)](https://travis-ci.org/factor-io/connector-tutum)
[![Gem Version](https://badge.fury.io/rb/factor-connector-tutum.svg)](http://badge.fury.io/rb/factor-connector-tutum)

Tutum Connector for Factor.io
======================

This gem provides Tutum actions through your Factor.io workflow. It was built with the [factor-connector-api](https://github.com/factor-io/connector-api) gem.

#Authentication

In order to make requests, you must obtain your [API key](https://dashboard.tutum.co/account/). Log onto Tutum, click on the menu on the upper right corner of the page and click `Account info`. You should then see the `Api Key` selection.

##Installation

Add this to your `Gemfile` in your [Connector](https://github.com/factor-io/connector).

```ruby
gem 'factor-connector-tutum', '~> 0.0.1'
```

Add this to your `init.rb` file.

```ruby
require 'factor/connector/tutum_service'
require 'factor/connector/tutum_container'
require 'factor/connector/tutum_cluster'
require 'factor/connector/tutum_node'
```
The [Connectors README](https://github.com/factor-io/connector#running) shows you how to run the Connector Server with this new connector integrated.

##Configuration

**[Setup your workflow](https://github.com/factor-io/connector-tutum/wiki/Workflow-Setup)**: To use the connector in your workflow when you run `factor s` you must setup your `credentials.yml` and `connectors.yml` files.

##Functionality

[example]

Further examples are provided in the **[Actions and Listeners](https://github.com/factor-io/connector-tutum/wiki/Actions-and-Listeners)** wiki.

##Testing

Using your terminal to test locally, you must set up two environmental variables.

```shell
$ export TUTUM_USERNAME=<username>
$ export TUTUM_API_KEY=<api_key>
```

Then, you can bundle and run the tests.

```shell
$ bundle exec rake
```

##Contributing

Documentation, feature requests, code, tests, and [bug reports](https://github.com/factor-io/connector-tutum/issues/new) are welcomed. Click [here](https://github.com/factor-io/factor/wiki/Contribution) for more information.
