# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_config_map resource class to get the information about specific Kubernetes config map in given namespace.
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

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'configmaps'
        super(opts)
      end

      def data
        resource.data.to_h
      end
    end
  end
end
