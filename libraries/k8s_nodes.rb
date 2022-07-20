# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    class K8sNodes < K8sObjects
      DEFAULT_NAMESPACE = nil

      name 'k8s_nodes'
      desc 'Verifies settings for all nodes'

      example "
      describe k8s_nodes do
        it { should exist }
        its('names') { should include 'my-node' }
        its('uids') { should include '6a1a4d2f-0953-4115-8564-acd7bb63a786'}
        ...
      end
    "

      def initialize(opts = {})
        opts[:type] = 'nodes'
        super(opts)
      end
    end
  end
end