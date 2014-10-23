require 'spec_helper'

describe 'Tutum' do
  describe 'Node' do
    it 'can list nodes' do

      service_instance = service_instance('tutum_node')

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

    it "can retrieve a node's information" do

      UUID = '3f5f2bf1-704a-4ba1-921d-43be01bc0b55'

      service_instance = service_instance('tutum_node')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'UUID' => UUID
      }

      service_instance.test_action('retrieve', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Parsing node information'
        expect_return
      end
    end
  end
end
