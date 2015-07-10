#!/usr/bin/env ruby
load 'ambari_client.rb'
require 'yaml'
require 'byebug'

# Parse command line.
cluster_name = ARGV[0]
datanode = ARGV[1]

# Load node attributes.
node_attr = YAML.load_file('cluster.yml')[0]

# Connect to ambari server.
connection = node_attributes['ambari_server']

# Create a new node with something like:
new_node = connection.add_host(cluster: node_attr['cluster'], components: node_attr['datanode'])



