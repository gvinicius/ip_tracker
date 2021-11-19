require_relative '../tracker.rb'

describe Tracker do
  let(:subject) { described_class.new() }

  it { is_expected.to respond_to(:ips) }

  describe '#request_handled(ip_address)' do
    let(:ip_address) { '145.87.2.109' }
    let(:empty_address) { '' }

    it 'stores an ip in memory' do
      expect{ subject.request_handled(ip_address) }.to change{ subject.ips }.from([]).to([ip_address])
    end

    it 'does not store an empty ip in memory' do
      expect{ subject.request_handled(empty_address) }.to_not change{ subject.ips }
    end
  end
end
