# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    class K8sConfigMaps < K8sObjects
      name 'k8s_config_maps'
      desc 'Verifies settings for all config maps'

      example "
      describe k8s_config_maps(namespace: 'default') do
        it { should exist }
        its('name') { should eq 'my-pod' }
        ...
      end
    "
      attr_reader :k8sobject

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:namespace], opts)
        @objtype = 'configmap'
        super(opts)
      end
    end
  end
end

