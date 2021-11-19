class Tracker
  attr_reader :ips

  def initialize()
    @ips = []
  end

  def request_handled(ip_address)
    ips << ip_address unless ip_address.empty?
  end
end
