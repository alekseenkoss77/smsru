require "spec_helper"

module Smsru
  describe API do

    shared_context "shared configuration", need_values: 'configuration' do
      before :each do
        Smsru.configure do |conf|
          conf.api_id = 'your-api-id'
          conf.from = 'sender-name'
          conf.test = test
          conf.format = format
        end
      end

      subject { Smsru::API }
    end

    shared_examples 'send_sms' do
      it { expect(VCR.use_cassette(cassette) { subject.send_sms(phone, text) }).to eq(response) }
    end

    shared_examples 'send_group_sms' do
      it { expect(VCR.use_cassette(cassette) { subject.group_send(phone, text) }).to eq(response) }
    end

    let(:text) { 'Sample of text that will have sended inside sms.' }
    let(:phone) { '+79050000000' }

    context 'test', need_values: 'configuration' do
      let(:test) { true }

      describe 'format = false' do
        it_behaves_like "send_sms" do
          let(:response) { "100\n000-00000" }
          let(:cassette) { 'api/send_sms' }
          let(:format) { false }
        end
      end

      describe 'error message' do
        let(:phone) { '0000' }
        let(:raw_response) { "202\n0000" }
        it_behaves_like "send_sms" do
          let(:response) { raw_response }
          let(:cassette) { 'api/error_sms' }
          let(:format) { false }
        end

        it_behaves_like "send_sms" do
          let(:response) { Smsru::Response.new(phone, raw_response) }
          let(:cassette) { 'api/error_sms' }
          let(:format) { true }
        end
      end

      describe 'group send sms' do
        let(:raw_response) { "100\n000-00000\n000-00000" }
        let(:phone) { ['+79050000000', '+79060000000'] }
        let(:cassette) { 'api/group_sms' }

        describe 'format = true' do
          it_behaves_like "send_group_sms" do
            let(:response_phone) { '+79050000000,+79060000000' }
            let(:response) { [Smsru::Response.new(response_phone, raw_response)] }
            let(:format) { true }
          end
        end

        describe 'format = false' do
          it_behaves_like "send_group_sms" do
            let(:response) { [raw_response] }
            let(:format) { false }
          end
        end

      end
    end

    context 'production', need_values: 'configuration' do
      let(:test) { false }

      describe 'send sms' do
        let(:raw_response) { "100\n000-00000\nbalance=1000" }
        let(:cassette) { 'api/send_sms_production' }
        describe 'format = false' do
          it_behaves_like "send_sms" do
            let(:response) { raw_response }
            let(:format) { false }
          end
        end

        describe 'format = true' do
          it_behaves_like "send_sms" do
            let(:response) { Smsru::Response.new(phone, raw_response) }
            let(:format) { true }
          end
        end
      end

      describe 'group send sms' do
        let(:raw_response) { "100\n000-00000\n000-00000\nbalance=1000" }
        let(:cassette) { 'api/group_sms_production' }
        let(:phone) { ['+79050000000', '+79060000000'] }
        let(:response_phone) { '+79050000000,+79060000000' }

        describe 'format = true' do
          it_behaves_like "send_group_sms" do
            let(:response) { [Smsru::Response.new(response_phone, raw_response)] }
            let(:format) { true }
          end
        end

        describe 'format = false' do
          it_behaves_like "send_group_sms" do
            let(:response) { [raw_response] }
            let(:format) { false }
          end
        end
      end
    end
  end
end