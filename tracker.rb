class Tracker
  attr_reader :ips

  def initialize()
    @ips = []
  end

  def request_handled(ip_address)
    ips << ip_address unless ip_address.empty?
  end

  def top100()
    return [] if ips.empty?

    ips.tally.to_a.group_by { |key, _| key }.map(&:last).flatten(1)
  end
end
