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

    it 'can create a cluster' do

      name             = 'TEST'
      node_type        = '/api/v1/nodetype/digitalocean/512mb/'
      region           = '/api/v1/region/digitalocean/lon1/'
      target_num_nodes = 1

      service_instance = service_instance('tutum_cluster')

      params = {
        'username' => @username,
        'api_key' => @api_key,
        'name' => name,
        'node_type' => node_type,
        'region' => region,
        'target_num_nodes' => target_num_nodes
      }

      service_instance.test_action('create', params) do
        expect_info message: 'Initializing connection to Tutum'
        expect_info message: 'Parsing creation response'
        expect_return
      end
    end
  end
end
