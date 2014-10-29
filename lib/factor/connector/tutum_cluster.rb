require 'factor-connector-api'
require 'tutum'

Factor::Connector.service 'tutum_cluster' do
  action 'list' do |params|

    username = params['username']
    api_key  = params['api_key']

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

    username = params['username']
    api_key  = params['api_key']
    uuid     = params['cluster_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A cluster UUID (cluster_id) is required' unless uuid

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.node_clusters.get(uuid)
      info 'Parsing cluster response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to retrieve cluster'
    end

    action_callback content
  end
end
