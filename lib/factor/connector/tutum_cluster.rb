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

  action 'create' do |params|

    username         = params['username']
    api_key          = params['api_key']
    name             = params['name']
    node_type        = params['node_type']
    region           = params['region']
    target_num_nodes = params['target_num_nodes']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A cluster name is required' unless name
    fail 'A node type (node_type) is required' unless node_type
    fail 'A region is required' unless region
    target_num_nodes ||= 1

    params = {
      name: name,
      node_type: node_type,
      region: region,
      target_num_nodes: target_num_nodes
    }

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.node_clusters.create(params)
      info 'Parsing creation response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to create cluster'
    end

    action_callback content
  end

  action 'get' do |params|

    username = params['username']
    api_key  = params['api_key']
    UUID     = params['cluster_id']

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
