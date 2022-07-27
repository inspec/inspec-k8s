# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_namespace resource to get data about specific kubernetes namespaces.
    class K8sNamespace < K8sObject
      DEFAULT_NAMESPACE = nil
      name 'k8s_namespace'
      desc 'Verifies settings for a specific namespace'

      example "
      describe k8s_namespace(name: 'kube-node-lease') do
        it { should exist }
        its('uid') { should eq '5ed76d62-838b-45cb-b41f-789b567a2fa2' }
        its('name') { should eq 'kube-node-lease' }
        its('kind') { should eq 'Namespace' }
        its('resource_version') { should eq '6' }
        its('creationTimestamp') { should eq '2022-07-21T10:47:49Z' }
        its('labels') { should eq 'kubernetes.io/metadata.name': 'kube-node-lease' }
        its('metadata') { should_not be_nil }
      end

      describe k8s_namespace(name: 'default') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'namespaces'
        super(opts)
      end
    end
  end
end
