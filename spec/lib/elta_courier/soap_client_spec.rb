require 'spec_helper'

RSpec.describe EltaCourier::SoapClient, :integration do
  let(:integration_double) do
    double(
      preferred_wsdl_url: ENV['ELTA_COURIER_WSDL_URL'],
      preferred_customer_code: ENV['ELTA_COURIER_CUSTOMER_CODE'],
      preferred_user_code: ENV['ELTA_COURIER_USER_CODE'],
      preferred_password: ENV['ELTA_COURIER_PASSWORD'],
      preferred_paper_size: "1"
    )
  end

  before do
    allow_any_instance_of(EltaCourier::SoapClient)
      .to receive(:store_integration)
      .with('elta_courier')
      .and_return(integration_double)
  end

  let(:client) { described_class.new }

  it "authenticates successfully with the test service" do
    key = client.authenticate!
    expect(key).to be_a(String)
    expect(key.length).to be > 0
    puts "Authentication key: #{key}"
  end
end
