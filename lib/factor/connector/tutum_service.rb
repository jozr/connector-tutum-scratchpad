require 'factor-connector-api'
require 'tutum'

Factor::Connector.service 'tutum_service' do
  action 'list' do |params|

    username       = params['username']
    api_key        = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.services.list
      info 'Parsing list response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to list services'
    end

    action_callback content
  end

  action 'get' do |params|

    username       = params['username']
    api_key        = params['api_key']
    UUID           = params['service_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A service UUID (service_id) is required' unless UUID

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.services.get(UUID)
      info 'Parsing service response'
      content = JSON.parse(response)
    rescue
      fail "Failed to retreive the service's information"
    end

    action_callback content
  end
end
