# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_namespaces resource to get data about all kubernetes namespaces.
    class K8sNamespaces < K8sObjects
      DEFAULT_NAMESPACE = nil
      name 'k8s_namespaces'
      desc 'Verifies settings for a specific deployment'

      example "
      describe k8s_namespaces do
        it { should exist }
        its('uids') { should include '5ed76d62-838b-45cb-b41f-789b567a2fa2' }
        its('names') { should include 'default' }
        its('resource_versions') { should include '6' }
        its('kinds') { should include 'Namespace' }
        its('labels') { should include 'kubernetes.io/metadata.name': 'default' }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'namespaces'
        super(opts)
      end
    end
  end
end
