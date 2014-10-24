require 'spec_helper'

describe 'Tutum' do
  describe 'Cluster' do
    it 'can list clusters' do

      service_instance = service_instance('tutum_cluster')

      params = {
        'username' => @username,
        'api_key' => @api_key
      }

      service_instance.test_action('list', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Parsing list response'
        expect_return
      end
    end

    it "can retrieve a cluster's information" do

      service_instance = service_instance('tutum_cluster')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'cluster_id' => @cluster_id
      }

      service_instance.test_action('get', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Parsing cluster response'
        expect_return
      end
    end
  end
end
