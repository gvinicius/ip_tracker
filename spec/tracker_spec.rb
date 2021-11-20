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

  describe '#top100()' do
    let(:ips) { [['145.87.2.109']*90, ['0.0.0.0']*9, ['1.8.2.1']].flatten }
    let(:empty_ips) { [] }

    context 'when the ips are filled' do
      before do
        allow(subject).to receive(:ips).and_return(ips)
      end

      it 'returns the correct rank' do
        expect(subject.top100()).to eq([['145.87.2.109', 90], ['0.0.0.0', 9], ['1.8.2.1', 1]])
      end
    end

    context 'when the ips are filled' do
      before do
        allow(subject).to receive(:ips).and_return(empty_ips)
      end

      it 'returns an empty rank' do
        expect(subject.top100()).to eq([])
      end
    end
  end

  describe '#clear()' do
    let(:ips) { [['145.87.2.109']*90, ['0.0.0.0']*9, ['1.8.2.1']].flatten }
    let(:empty_ips) { [] }

    context 'when the ips are filled' do
      before do
        subject.ips = ips
      end

      it 'clears the ips object' do
        expect{ subject.clear() }.to change{ subject.ips }.from(ips).to([])
      end
    end

    context 'when the ips are filled' do
      it 'does not affect the ips object' do
        expect{ subject.clear() }.to_not change{ subject.ips }
      end
    end
  end
end
