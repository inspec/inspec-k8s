# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_network_policies resource to get data about all kubernetes network policies.
    class K8sNetworkPolicies < K8sObjects
      name 'k8s_network_policies'
      desc 'Verifies settings for all networkpolicies'

      example "
      describe k8s_network_policies do
        it { should exist }
        its('names') { should include 'test-network-policy' }
        its('uids') { should include '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
        its('resource_versions') { should include '129558' }
        its('labels') { should_not be_empty }
        its('annotations') { should_not be_empty }
        its('namespaces') { should include 'default' }
        its('kinds') { should include 'NetworkPolicy' }
        its('metadata') { should_not be_nil }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'networkpolicies'
        opts[:api] = 'networking.k8s.io/v1'
        super(opts)
      end
    end
  end
end
