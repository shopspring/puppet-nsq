#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nsq](#setup)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nsq](#beginning-with-nsq)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Installs and configures NSQ [http://nsq.io]

[![Build Status](https://travis-ci.org/shopspring/puppet-nsq.svg?branch=master)](https://travis-ci.org/shopspring/puppet-nsq)

## Module Description

The NSQ module installs, configures and optionally sets up a service for running NSQ on Ubuntu 16.04.

## Setup


### Setup Requirements

* wget module - [https://forge.puppet.com/maestrodev/wget]


### Beginning with nsq
```puppet
include nsq
include nsq::nsqlookupd
include nsq::nsqadmin
include nsq::nsqd
```

## Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

Currently only tested on Ubuntu 16.04 and Puppet 4.x

