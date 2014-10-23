require 'codeclimate-test-reporter'
require 'rspec'
require 'wrong'
require 'factor-connector-api/test'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

Dir.glob('./lib/factor/connector/*.rb').each { |f| require f }

RSpec.configure do |c|
  c.include Factor::Connector::Test

  c.before do
    @node_id = '3f5f2bf1-704a-4ba1-921d-43be01bc0b55'
    @cluster_id = '7a1138f6-75fd-499d-8029-ff407eec4c61'
    @username = ENV['TUTUM_USERNAME']
    @api_key = ENV['TUTUM_API_KEY']
  end
end
