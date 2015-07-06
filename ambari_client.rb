require 'rest_client'

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
    res = JSON(RestClient.get(@uri + "clusters/"))['items']
    clusters = res['items'].collect { |item| item["Clusters"]["cluster_name"]}
    return clusters
  end

  def hosts(cluster)
    res = JSON(RestClient.get(@uri + "clusters/#{cluster}/hosts/"))
    hosts = res['items'].collect { |item| item["Hosts"]["host_name"]}
  end
end


