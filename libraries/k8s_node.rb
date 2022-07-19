# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    class K8sNode < K8sObject
      DEFAULT_NAMESPACE = nil

      name 'k8s_node'
      desc 'Verifies settings for a specific node'

      example "
      describe k8s_node(name: 'my-node') do
        it { should exist }
        its('name') { should eq 'my-node' }
        ...
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'nodes'
        super(opts)
      end
    end
  end
end