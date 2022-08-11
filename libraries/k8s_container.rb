# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_container resource to get data about specific container in given kubernetes namespace.
    class K8sContainer < K8sObject
      name 'k8s_container'
      desc 'Verifies settings for a specific container'

      example "
      describe k8s_container(namespace: 'my-namespace', pod_name: 'my-pod', name: 'hello-world') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:pod_name, :name], opts)
        opts[:type] = 'pods'
        @container_name = opts[:name]
        opts[:name] = opts[:pod_name]
        super(opts)
        set_resource
      end

      private
      def set_resource
        @k8sobject = @k8sobject.spec.containers.select{|container| container.name == @container_name }
      end
    end
  end
end

