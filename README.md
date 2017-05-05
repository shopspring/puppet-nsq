#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with nsq](#setup)
    * [What nsq affects](#what-nsq-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with nsq](#beginning-with-nsq)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Installs and configures NSQ [http://nsq.io]

## Module Description

The NSQ module installs, configures and optionally sets up a service for running NSQ on Ubuntu 16.04.

## Setup

### What nsq affects

* A list of files, packages, services, or operations that the module will alter, impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form. 

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled, etc.), mention it here. 

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

