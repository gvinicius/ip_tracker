require 'concurrent'

BATCH_SIZE = 10
EXPECTED_TOP_RESULTS = 100

class Tracker
  attr_accessor :ips

  def initialize()
    @ips = []
  end

  #
  def request_handled(ip_address)
    ips << ip_address unless ip_address.empty?
  end

  # Auxiliary method. It helps the following method to count entries from a given group of ips.
  def count_entries(ips)
    return [] if ips.empty?

    ips.tally.to_a.group_by { |key, _| key }.map(&:last).flatten(1)
  end

  # It counts ips in a multithread approach and by batches.
  def top100()
    async_sums_in_batches = ips.each_slice(BATCH_SIZE).map do |ips_batch|
      Concurrent::Promises.future { count_entries(ips_batch) }
    end

    partial_sums = Concurrent::Promises.zip(*async_sums_in_batches).value!
    combined_sums = partial_sums.flatten(1).group_by { |key, _| key }.
      map { |ip, counting| [ip, counting.map(&:last).sum ] }

    index_of_expected_top_result = EXPECTED_TOP_RESULTS - 1
    top_results = combined_sums[0, index_of_expected_top_result]
    top_results
  end

  # The clear method is a built-in bevahior in Array, which is faster than re-assign the variable
  # to an empty array.
  def clear()
    self.ips.clear unless self.ips.empty?
  end
end
