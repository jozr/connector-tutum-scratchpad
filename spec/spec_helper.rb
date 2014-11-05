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
    @service_id   = ENV['TUTUM_SERVICE_ID']
    @session      = Tutum.new(@username, @api_key)
    params = {
      name: 'TEST49',
      node_type: '/api/v1/nodetype/digitalocean/512mb/',
      region: '/api/v1/region/digitalocean/lon1/',
      target_num_nodes: 1
    }
    cluster       = @session.node_clusters.create(params)
    @cluster_id   = cluster['uuid']
    @node_id      = cluster['nodes'].first.split('/').last
    service       = @session.services.get(@service_id)
    @container_id = service['containers'].first.split('/').last
  end

  c.after do
    response = @session.node_clusters.list
    response['objects'].each do |cluster|
      if cluster['name'] == 'TEST49' && cluster['state'] != 'Terminated'
        @session.node_clusters.terminate(cluster['uuid'])
      end
    end
  end
end
