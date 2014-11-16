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
      info 'Requesting list of clusters'
      response = session.node_clusters.list
    rescue
      fail 'Failed to list clusters'
    end

    action_callback response
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
      info 'Requesting cluster information'
      response = session.node_clusters.get(uuid)
    rescue
      fail 'Failed to retrieve cluster'
    end

    action_callback response
  end

  action 'create' do |params|

    username         = params['username']
    api_key          = params['api_key']
    name             = params['name']
    node_type        = params['node_type']
    region           = params['region']
    target_num_nodes = params['target_num_nodes'] || 1

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A cluster name is required' unless name
    fail 'A node type (node_type) is required' unless node_type
    fail 'A region is required' unless region

    params = {
      name: name,
      node_type: node_type,
      region: region,
      target_num_nodes: target_num_nodes
    }

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Requesting creation of cluster'
      response = session.node_clusters.create(params)
    rescue
      fail 'Failed to create cluster'
    end

    action_callback response
  end
end

