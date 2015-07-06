require 'rest_client'
require 'byebug'

class AmbariCluster

  attr_writer :password
  attr_accessor :user, :host, :port

  def initialize(host:, port:, user:, password:)
    @host     = host
    @port     = port
    @user     = user
    @password = password

    @uri = "http://#{@user}:#{@password}@#{@host}:#{port}/api/v1/"

    @test_cluster = { "c1" => { }, "c2" => {} }
  end

  def clusters
    # Fetch a list of clusters this ambari server manages
    # returns an array
    res = JSON(RestClient.get(@uri + "clusters/"))['items']
    clusters = res['items'].collect { |item| item["Clusters"]["cluster_name"]}
    return clusters
  end

  def cluster(cluster)
    # Fetch a JSON object describing the named cluster
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}"))
    return res
  end

  def hosts(cluster)
    # Fetch a list of hosts within a named cluster
    # returns an array
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}/hosts/"))
    hosts = res['items'].collect { |item| item["Hosts"]["host_name"]}
    return hosts
  end

  def host(cluster, host)
    # Fetch a JSON object describing the named host
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}/hosts/#{host}/"))
    return res
  end

  def services(cluster)
    # Fetch a list of services within a named cluster
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}/services/"))
    services = res['items'].collect { |item| item["ServiceInfo"]["service_name"]}
    return services
  end

  def service(cluster, service)
    # Fetch a JSON object describing the names service
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}/services/#{service}"))
    return res
  end
end


