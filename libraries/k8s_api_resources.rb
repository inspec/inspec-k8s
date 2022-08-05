# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_api_resources class gets settings for specified kubernetes api resources.
    class K8sApiResources < K8sObjects
      name 'k8s_api_resources'
      desc 'Verifies settings for specified kubernetes api resources'

      example "
        describe k8s_api_resources(api: 'apps/v1') do
          it { should exist }
          its('name') { should include 'daemonsets' }
          its('singularName') { should include '' }
          its('namespaced') { should include true }
          its('group') { should include 'autoscaling' }
          its('version') { should include 'v1' }
          its('kind') { should include 'DaemonSet' }
          its('shortNames') { should include 'ds' }
          its('categories') { should include 'all' }
        end

        describe k8s_api_resources do
          it { should exist }
          its('kind') { should include 'ConfigMap' }
        end
      "

      attr_reader :k8s_apis_obj, :table

      def initialize(opts = {})
        super(opts)
        @objapi = opts[:api] if opts[:api] ||= 'v1'
        @obj_label_selector = opts[:labelSelector] if opts[:labelSelector] ||= nil
        fetch_data
        populate_filter_table_from_response
      end

      private

      def fetch_data
        # @note: check how to use labelSelector
        catch_k8s_errors do
          @k8s_apis_obj = @k8s.client.api(@objapi).api_resources
        end

        return [] unless @k8s_apis_obj

        @table = @k8s_apis_obj.map(&:to_h)
      end

      def populate_filter_table_from_response
        return unless @table.present?

        table_schema = @table.first.keys.map { |key| { column: key.to_s.to_sym, field: key, style: :simple } }
        Inspec::Resources::K8sApiResources.populate_filter_table(:table, table_schema)
      end
    end
  end
end
