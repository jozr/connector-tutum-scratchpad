require 'factor-connector-api'
require 'tutum'

Factor::Connector.service 'tutum_service' do
  action 'list' do |params|

    username = params['username']
    api_key  = params['api_key']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Requesting list of services'
      response = session.services.list
    rescue
      fail 'Failed to list services'
    end

    action_callback response
  end

  action 'get' do |params|

    username = params['username']
    api_key  = params['api_key']
    uuid     = params['service_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A service UUID (service_id) is required' unless uuid

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Requesting service information'
      response = session.services.get(uuid)
    rescue
      fail "Failed to retreive the service's information"
    end

    action_callback response
  end

  action 'logs' do |params|

    username = params['username']
    api_key  = params['api_key']
    uuid     = params['service_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A service UUID (service_id) is required' unless uuid

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Requesting service logs'
      response = session.services.logs(uuid)
    rescue
      fail "Failed to retreive the service's information"
    end

    action_callback response
  end

  action 'start' do |params|

    username = params['username']
    api_key  = params['api_key']
    uuid     = params['service_id']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A service UUID (service_id) is required' unless uuid

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Starting service'
      response = session.services.start(uuid)
    rescue
      fail "Failed to start the service"
    end

    action_callback response
  end

  action 'create' do |params|

    username         = params['username']
    api_key          = params['api_key']
    image_url        = params['image_url']
    name             = params['name']
    target_num_nodes = params['target_num_nodes']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A image location (image_url) is required' unless image_url
    name ||= 'Foo'
    target_num_nodes ||= 1

    params = {
      image: image_url,
      name: name,
      target_num_nodes: target_num_nodes
    }

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      info 'Creating service'
      response = session.services.create(params)
    rescue
      fail "Failed to create the service"
    end

    action_callback response
  end
end
