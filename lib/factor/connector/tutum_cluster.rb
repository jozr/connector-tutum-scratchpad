require 'factor-connector-api'
require 'rest-client'

Factor::Connector.service 'tutum_cluster' do
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
      application_url = 'https://dashboard.tutum.co/api/v1/nodecluster'
      response        = RestClient.get(application_url,headers)
      info 'Parsing list response'
      contents        = JSON.parse(response)
    rescue
      fail 'Failed to list clusters'
    end

    action_callback contents
  end

  action 'get' do |params|

    username       = params['username']
    api_key        = params['api_key']
    UUID           = params['cluster_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A cluster ID (cluster_id) is required' unless UUID

    info 'Initializing connection to Tutum'
    begin
      headers = {
        "Authorization"=>"ApiKey #{username}:#{api_key}",
        "Accept" => "application/json"
      }
      application_url = "https://dashboard.tutum.co/api/v1/nodecluster/#{UUID}"
      response        = RestClient.get(application_url,headers)
      info 'Parsing cluster response'
      contents        = JSON.parse(response)
    rescue
      fail 'Failed to retrieve cluster'
    end

    action_callback contents
  end
end
