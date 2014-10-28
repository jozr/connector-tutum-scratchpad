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

  action 'create' do |params|

    username              = params['username']
    api_key               = params['api_key']
    image                 = params['image']
    name                  = params['name']
    target_num_containers = params['target_num_containers']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'An image is required' unless image
    fail 'A name is required' unless name
    target_num_containers ||= 1

    params = {
      image: image,
      name: name, 
      target_num_containers: target_num_containers
    }

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
      response = session.services.create(params)
      info 'Parsing creation response'
      content = JSON.parse(response)
    rescue
      fail 'Failed to create service'
    end

    action_callback content
  end
end
