# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_containers resource to get data about all kubernetes containers.
    class K8sContainers < K8sObjects
      name 'k8s_containers'
      desc 'Verifies settings for all containers'

      example "
      describe k8s_containers do
        it { should exist }
        its('names') { should include 'hello' }
        its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
      end

      describe k8s_containers(namespace: 'my-namespace') do
        it { should exist }
        its('names') { should include 'hello-world' }
      end
    "
      table_schema = [
        { column: :volumeMounts, field: :volumeMounts },
        { column: :imagePullPolicies, field: :imagePullPolicy },
        { column: :commands, field: :commands },
        { column: :resources, field: :resources },
        { column: :livenessProbes, field: :livenessProbe },
        { column: :readinessProbes, field: :readinessProbe },
        { column: :securityContexts, field: :securityContext },
        { column: :args, field: :args }
      ]
      self.populate_filter_table(:table, table_schema)

      def initialize(opts = {})
        opts[:type] = 'pods'
        super(opts)
      end

      private

      def containers
        @k8sobjects.map(&:spec).map(&:containers).flatten
      end

      def build_table
        containers.map do |obj|
          build_record_from(obj)
        end
      end

      def build_record_from(obj)
        obj.to_h
      end
    end
  end
end

