require "spec_helper"

module Smsru
  describe Response do

    shared_context "used received single code", need_values: 'single_response' do
      let(:response_hash) { {code: ['000000-000000'], phone: phone, raw: response, status: '100', message: Status::SMS_STATUS['100'], balance: balance} }
    end

    shared_context "used received several of codes", need_values: 'several_response' do
      let(:response_hash) { {code: ['000000-000000', '000000-000000'], phone: phone, raw: response, status: '100', message: Status::SMS_STATUS['100'], balance: balance} }
    end

    shared_examples 'instance methods' do
      subject { Response.new(phone, response) }

      it { expect(subject.success?).to be_truthy }
      it { expect(subject.fail?).to be_falsey }
      it { expect(subject.to_h).to eq(response_hash) }
    end

    describe 'received single code', need_values: 'single_response' do
      let(:phone) { '+79050000000' }
      describe 'test true' do
        it_behaves_like "instance methods" do
          let(:response) { "100\n000000-000000" }
          let(:balance) { nil }
        end
      end

      describe 'test false' do
        it_behaves_like "instance methods" do
          let(:balance) { '1000' }
          let(:response) { "100\n000000-000000\nbalance=#{balance}" }
        end
      end
    end

    describe 'received several of codes', need_values: 'several_response' do
      let(:phone) { '+79050000000,+79060000000' }
      describe 'test true' do
        it_behaves_like "instance methods" do
          let(:response) { "100\n000000-000000\n000000-000000" }
          let(:balance) { nil }
        end
      end

      describe 'test false' do
        it_behaves_like "instance methods" do
          let(:balance) { '1000' }
          let(:response) { "100\n000000-000000\n000000-000000\nbalance=#{balance}" }
        end
      end
    end
  end
end