# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    class K8sConfigMap < K8sObject
      name 'k8s_config_map'
      desc 'Verifies settings for a specific config map'

      example "
      describe k8s_config_map(namespace: 'default', name: 'my-pod-cm') do
        it { should exist }
        its('name') { should eq 'my-pod-cm' }
        ...
      end
    "
      attr_reader :k8sobject

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        @objtype = 'configmap'
        super(opts)
      end
    end
  end
end
