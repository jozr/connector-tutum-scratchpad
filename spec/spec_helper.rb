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
		@node_id      = ENV['TUTUM_NODE_ID']
		@cluster_id   = ENV['TUTUM_CLUSTER_ID']
		@container_id = ENV['TUTUM_CONTAINER_ID']
		@service_id   = ENV['TUTUM_SERVICE_ID']
	end

	c.after do
		session = Tutum.new(@username, @api_key)
		clusters_response = session.node_clusters.list
		clusters = JSON.parse(clusters_response)
		clusters['objects'].each do |cluster|
			if cluster['name'] == 'TEST49' && cluster['state'] != 'Terminated'
				session.node_clusters.terminate(cluster['uuid'])
			end
		end
	end
end
