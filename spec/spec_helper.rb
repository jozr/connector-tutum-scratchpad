require 'codeclimate-test-reporter'
require 'rspec'
require 'wrong'
require 'factor-connector-api/test'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

Dir.glob('./lib/factor/connector/*.rb').each { |f| require f }

RSpec.configure do |c|
c.include Factor::Connector::Test

  c.before do
    @username     = ENV['TUTUM_USERNAME']
    @api_key      = ENV['TUTUM_API_KEY']
    @image_url    = ENV['TUTUM_IMAGE_URL'] 
    @container_id = ENV['TUTUM_CONTAINER_ID']  
    @session      = Tutum.new(@username, @api_key)

    cluster_params = {
      name: 'TEST49',
      node_type: '/api/v1/nodetype/digitalocean/512mb/',
      region: '/api/v1/region/digitalocean/lon1/',
      target_num_nodes: 1
    }

    service_params = {
      image: @image_url,
      name: 'TEST48',
      target_num_containers: 1
    }

    cluster     = @session.node_clusters.create(cluster_params)
    service     = @session.services.create(service_params)
    service_two = @session.services.create(service_params)

    @cluster_id     = cluster['uuid']
    @service_id     = service['uuid']
    @service_id_two = service_two['uuid']
    @node_id        = cluster['nodes'].first.split('/').last
  end

  c.after do
    @session.services.terminate(@service_id)

    services_response = @session.services.list
    services_response['objects'].each do |service|
      if service['name'] == 'TEST47' && service['state'] != 'Terminated'
        @session.services.terminate(service['uuid'])
      end
    end

    clusters_response = @session.node_clusters.list
    clusters_response['objects'].each do |cluster|
      if cluster['name'] == 'TEST49' && cluster['state'] != 'Terminated'
        @session.node_clusters.terminate(cluster['uuid'])
      end
    end
  end
end
