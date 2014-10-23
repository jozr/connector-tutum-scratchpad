require 'spec_helper'

describe 'Tutum' do
  describe 'Container' do
    it 'can list containers' do

      service_instance = service_instance('tutum_container')

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
  end
end
