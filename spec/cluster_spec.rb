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

      UUID = '7a1138f6-75fd-499d-8029-ff407eec4c61'
      service_instance = service_instance('tutum_cluster')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'UUID' => UUID
      }

      service_instance.test_action('retrieve', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Parsing cluster response'
        expect_return
      end
    end
  end
end
