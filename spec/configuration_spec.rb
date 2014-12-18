require 'spec_helper'

describe Smsru::Configuration do

  let(:conf) { Rails.application.config.smsru }

  specify { expect(conf).to_not be_nil }

  specify { expect(conf.sms_url).to eq "http://sms.ru/sms/send?" }

  it "should load config from file" do
    expect(conf.test).to be_truthy
  end

  it "should set config within initializer" do
    expect(conf.format).to be_falsey
    expect(conf.from).to eq 'initializer'
    expect(conf.api_id).to eq 'test-api-2'
  end

  unless Rails.application.try(:secrets).nil?
    it "should load config from secrets" do
      expect(conf.mail).to eq "test@sms.ru"
    end
  end
end
