# frozen_string_literal: true

require 'k8s_backend'
require 'active_support/core_ext/string'

module Inspec
  module Resources
    class K8sObjects < K8sResourceBase
      name 'k8sobjects'
      desc 'Gets a list of a given type of Kubernetes Object'

      example "
        describe k8sobjects(api: 'v1', type: 'pods', namespace: 'default',
                            labelSelector: 'run=nginx') do
          it { should exist }
          ...
        end
        describe k8sobjects(api: 'v1', type: 'namespaces',
                            labelSelector: 'myns=prod') do
          it { should exist }
          ...
        end
      "

      # FilterTable setup
      filter_table_config = FilterTable.create
      %i[name namespace kind uid resource_version labels annotations].each do |field|
        filter_table_config.register_column(field.to_s.underscore.pluralize, field: field)
      end
      filter_table_config.install_filter_methods_on_resource(self, :fetch_data)

      def initialize(opts = {})
        # Call the parent class constructor
        super(opts)
        @objapi = opts[:api] if opts[:api] ||= 'v1'
        @objtype = opts[:type] if opts[:type] ||= nil
        @objname = opts[:name] if opts[:name] ||= nil
        @objnamespace = opts[:namespace] if opts[:namespace] ||= nil
        @objlabelSelector = opts[:labelSelector] if opts[:labelSelector] ||= nil
        fetch_data
        populate_filter_table_from_response
      end

      def fetch_data
        catch_k8s_errors do
          getobjects
        end

        return [] unless @k8sobjects

        @table = build_table
      end

      def getobjects
        @k8sobjects = if !@objnamespace.nil?
                        @k8s.client.api(@objapi).resource(@objtype,
                                                          namespace: @objnamespace).list(labelSelector: @objlabelSelector)
                      else
                        @k8s.client.api(@objapi).resource(@objtype).list(labelSelector: @objlabelSelector)
                      end
      end

      def items
        entries
      end

      private

      def populate_filter_table_from_response
        return unless @table.present?

        table_schema = @table.first.keys.map { |key| { column: key.to_s.pluralize.to_sym, field: key, style: :simple } }
        Inspec::Resources::K8sObjects.populate_filter_table(:table, table_schema)
      end

      def build_table
        @k8sobjects.map do |obj|
          build_record_from(obj)
        end
      end

      def build_record_from(obj)
        hash = obj.to_h
        hash[:status] = hash[:status].to_h
        hash.merge!(obj.metadata.to_h.transform_keys { |key| key.to_s.underscore.to_sym })
        hash[:labels] = obj.metadata.labels&.map(&:to_h)
        hash[:annotations] = obj.metadata.annotations&.map(&:to_h)
        hash
      end
    end
  end
end
