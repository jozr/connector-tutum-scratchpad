require 'factor-connector-api'
require 'rest-client'

Factor::Connector.service 'tutum_node' do
  action 'list' do |params|

    username       = params['username']
    api_key        = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      headers = {
        "Authorization"=>"ApiKey #{username}:#{api_key}",
        "Accept" => "application/json"
      }
      node_url = 'https://dashboard.tutum.co/api/v1/node'
      response      = RestClient.get(node_url,headers)
      info 'Parsing list response'
      contents      = JSON.parse(response)
    rescue
      fail 'Failed to list nodes'
    end

    action_callback contents
  end

  action 'retrieve' do |params|

    username       = params['username']
    api_key        = params['api_key']
    UUID           = params['node_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A node ID (node_id) is required' unless UUID

    info 'Initializing connection to Tutum'
    begin
      headers = {
        "Authorization"=>"ApiKey #{username}:#{api_key}",
        "Accept" => "application/json"
      }
      node_url = "https://dashboard.tutum.co/api/v1/node/#{UUID}"
      response      = RestClient.get(node_url,headers)
      info 'Parsing node information'
      contents      = JSON.parse(response)
    rescue
      fail 'Failed to list nodes'
    end

    action_callback contents
  end
end
