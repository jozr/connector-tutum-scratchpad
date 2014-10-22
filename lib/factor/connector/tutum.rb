require 'factor-connector-api'
require 'tutum'

Factor::Connector.service 'tutum' do
  action 'create' do |params|

    username       = params['username']
    api_key        = params['api_key']
    name           = params['name']
    image          = params['image']
    container_size = params['container_size']
    web_public_dns = params['web_public_dns']

    fail 'A username is required' unless username
    fail 'An API key (api_key) is required' unless api_key
    fail 'A container name is required' unless name
    fail 'An image is required' unless image
    fail 'A domain URI (web_public_dns) is required' unless web_public_dns

    content = {
      :image => image,
      :name => name,
      :container_size => container_size,
      :web_public_dns => web_public_dns
    }

    info 'Initializing connection to Tutum'
    begin
      session = Tutum.new(username, api_key)
    rescue
      fail 'Authentication invalid'
    end

    info 'Creating new container'
    begin
      container = session.containers.create(content)
    rescue
      fail 'Failed to create container'
    end

    action_callback container
  end
end
