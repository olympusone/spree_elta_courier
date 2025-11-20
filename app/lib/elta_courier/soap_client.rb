require 'savon'

module EltaCourier
  class SoapClient
    include Spree::IntegrationsConcern

    SERVICE_WSDL_FILES = {
      create: 'CREATEAWB02.wsdl',
      print:  'PELB64VG.wsdl',
      track:  'PELTT03.wsdl',
      pudo:   'GETPUDODETAILS.wsdl'
    }.freeze

    attr_reader :client

    def initialize(service)
      integration = store_integration('elta_courier')
      raise 'Integration not found' unless integration

      wsdl_url = integration.preferred_wsdl_url
      raise 'WSDL URL is required' unless wsdl_url

      wsdl_source = resolve_wsdl(service)

      @customer_code = integration.preferred_customer_code
      @user_code = integration.preferred_user_code
      @password = integration.preferred_password

      @client = Savon.client(
        wsdl: wsdl_source,
        endpoint: wsdl_url,
        convert_request_keys_to: :none
      )
    end

    def call(method, message = {})
      begin
        response = client.call(
          method,
          message: default_auth_params.merge(message)
        )

        response.body.dig(:"#{method}_response")
      rescue Savon::SOAPFault => e
        raise SoapError, "SOAP Fault: #{e.message}"
      rescue Savon::HTTPError => e
        raise SoapError, "HTTP Error: #{e.message}"
      rescue Savon::UnknownOperationError
        raise SoapError, "Unknown SOAP method: #{method}"
      rescue Savon::Error => e
        raise SoapError, "SOAP call failed: #{e.message}"
      end
    end

    def default_auth_params
      {
        'pel_apost_code' => @customer_code,
        'pel_user_code' => @user_code,
        'pel_user_pass' => @password
      }.compact
    end

    def resolve_wsdl(service)
      filename = SERVICE_WSDL_FILES[service]
      raise ArgumentError, "Unknown ELTA service: #{service}" unless filename

      SpreeEltaCourier::Engine.root.join('lib', 'spree_elta_courier', 'wsdl', filename).to_s
    end

    class SoapError < StandardError; end
  end
end
