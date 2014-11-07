require 'spec_helper'

describe 'Tutum' do
  describe 'Service' do
    it 'can list services' do

      service_instance = service_instance('tutum_service')

      params = {
        'username' => @username,
        'api_key' => @api_key
      }

      service_instance.test_action('list', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Requesting list of services'
        expect_return
      end
    end

    it "retrieve a service's information" do

      service_instance = service_instance('tutum_service')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'service_id' => @service_id
      }

      service_instance.test_action('get', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Requesting service information'
        expect_return
      end
    end

    it 'can get the logs of a service' do

      service_instance = service_instance('tutum_service')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'service_id' => @service_id
      }

      service_instance.test_action('logs', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Requesting service logs'
        expect_return
      end
    end

    it 'can create a new service' do

      name             = 'TEST47'
      target_num_nodes = 1
      
      service_instance = service_instance('tutum_service')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'image_url' => @image_url,
        'name' => name,
        'target_num_nodes' => target_num_nodes
      }

      service_instance.test_action('create', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Creating service'
        expect_return
      end
    end

    it 'can terminate a service' do

      service_id = @service_id_two
      
      service_instance = service_instance('tutum_service')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'service_id' => service_id
      }

      service_instance.test_action('terminate', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Terminating service'
        expect_return
      end
    end
  end
end
