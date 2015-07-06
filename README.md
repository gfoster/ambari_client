# ambari_client
quick and dirty ruby access to ambari resources

This class was written to scratch a personal itch. It's ugly and
more than likely not going to work for you but you're welcome to poke
around with it anyway.

In a nutshell, it abstracts a lot of the REST calls to an ambari
server within an AmbariClient class

require 'AmbariClient'

foo = AmbariClient.new(host: "myhost", port: 8080, user: "admin", password:"admin")

foo.clusters => return an array of clusters managed by the ambari
server

foo.cluster(cluster) => return a JSON object describing that cluster

foo.hosts(cluster) => array of hosts in the cluster

foo.host(cluster, host) => JSON object describing host

foo.services(cluster) => array of services in the cluster

foo.service(cluster, service) => JSON object describing service
