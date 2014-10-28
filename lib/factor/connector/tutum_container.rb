require 'factor-connector-api'
require 'tutum'

Factor::Connector.service 'tutum_container' do
  action 'list' do |params|

    username       = params['username']
    api_key        = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.containers.list
      info 'Parsing list response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to list containers'
    end

    action_callback content
  end
end
