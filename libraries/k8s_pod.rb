# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    class K8sPod < K8sObject
      name 'k8s_pod'
      desc 'Verifies settings for a specific pod'

      example "
      describe k8s_pod(namespace: 'default', name: 'my-pod') do
        it { should exist }
        its('name') { should eq 'my-pod' }
        ...
      end
    "
      attr_reader :k8sobject

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        @objtype = 'pods'
        super(opts)
      end
    end
  end
end