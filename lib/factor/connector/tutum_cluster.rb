require 'factor-connector-api'
require 'tutum'
require 'json'

Factor::Connector.service 'tutum_cluster' do
  action 'list' do |params|

    username       = params['username']
    api_key        = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.node_clusters.list
      info 'Parsing list response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to list clusters'
    end

    action_callback content
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
      session = Tutum.new(username, api_key)
      response = session.node_clusters.get(UUID)
      info 'Parsing cluster response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to retrieve cluster'
    end

    action_callback content
  end
end
