load 'ambari_client.rb'

class Host
  attr_accessor :hostname, :conn, :cluster, :components

  def initialize(hostname)
    @hostname = hostname
    @conn = AmbariCluster.new(host: "ambari.smoke.vpc.rgops.com", port: 8080, user: "admin", password: "admin")
    @cluster = "Smoke"
    @components = @conn.host_components(cluster: @cluster, host: @hostname)
  end

  def stop_components()
    # Status checks whether the task is in progress or complete. TODO: polling every second.
    @components.each { |c| 
      status = @conn.stop_component(cluster: @cluster, host: @hostname, component: c)
      puts JSON.parse(status)['Requests']['status']
      puts "Stopped #{c}."}
  end

  def start_components()
    @components.each { |c| @conn.start_component(cluster: @cluster, host: @hostname, component: c)
      puts "Stopped #{c}."}
  end

  def remove_components()
    components.each { |c| @conn.remove_component(cluster: @cluster, host: @hostname, component: c)
      puts "  #{c}."}
  end

  def add_components()
    @components.each { |c| @conn.add_component(cluster: @cluster, host: @hostname, component: c)
      puts "Added #{c}."}
  end

end

h = Host.new("data01-smoke-hdp.ulive.sh")
h.stop_components()


