# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_network_policy resource class to get information about specific Kubernetes network-policy in given namespace.
    class K8sNetworkPolicy < K8sObject
      name 'k8s_network_policy'
      desc 'Verifies settings for a specific network-policy'

      example "
      describe k8s_network_policy(name: 'test-network-policy') do
        it { should exist }
        its('uid') { should eq '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
        its('resource_version') { should eq '129558' }
        its('labels') { should be_empty }
        its('annotations') { should_not be_empty }
        its('name') { should eq 'test-network-policy' }
        its('namespace') { should eq 'default' }
        its('kind') { should eq 'NetworkPolicy' }
        its('creation_timestamp') { should eq '2022-08-02T09:47:56Z' }
        its('metadata') { should_not be_nil }
      end

      describe k8s_network_policy(name: 'my-network-policy', namespace: 'my-namespace') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'networkpolicies'
        opts[:api] = 'networking.k8s.io/v1'
        super(opts)
      end
    end
  end
end
