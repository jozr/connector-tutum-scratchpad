require 'spec_helper'

describe 'Tutum' do
  describe 'Container' do
    it 'can create a container' do

      name = 'Test'
      image = 'tutum/test'
      container_size = 'XS'
      web_public_dns = 'test.test.com'

      service_instance = service_instance('tutum')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'name' => name,
        'image' => image,
        'container_size' => container_size,
        'web_public_dns' => web_public_dns
      }

      service_instance.test_action('create', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Creating new container'
        expect_return
      end
    end
  end
end
