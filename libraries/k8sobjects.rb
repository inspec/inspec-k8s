# frozen_string_literal: true

require 'k8s_backend'
require 'active_support/core_ext/string'

module Inspec
  module Resources
    # k8s_objects resource class gets list of kubernetes resource with given type.
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

      # Populate the FilterTable.
      # replicated from https://github.com/inspec/inspec-azure/blob/main/libraries/azure_generic_resources.rb#L113
      # FilterTable is a class bound object so is this method.
      # @param raw_data [Symbol] Method name of the table with raw data.
      # @param table_scheme [Array] [{column: :blahs, field: :blah}, {..}]
      def self.populate_filter_table(raw_data, table_scheme)
        filter_table = FilterTable.create
        table_scheme.each do |col_field|
          opts = { field: col_field[:field] }
          opts[:style] = col_field[:style] if col_field[:style]
          filter_table.register_column(col_field[:column], opts)
        end
        filter_table.install_filter_methods_on_resource(self, raw_data)
      end

      attr_reader :k8sobject, :table

      def initialize(opts = {})
        # Call the parent class constructor
        super(opts)
        @objapi = opts[:api] if opts[:api] ||= 'v1'
        @objtype = opts[:type] if opts[:type] ||= nil
        @objname = opts[:name] if opts[:name] ||= nil
        @objnamespace = opts[:namespace] if opts[:namespace] ||= nil
        @obj_label_selector = opts[:labelSelector] if opts[:labelSelector] ||= nil
        fetch_data
        populate_filter_table_from_response
      end

      def fetch_data
        catch_k8s_errors do
          getobjects
        end

        return unless @k8sobjects

        @table = build_table
      end

      def getobjects
        @k8sobjects = if @objnamespace.nil?
                        @k8s.client.api(@objapi).resource(@objtype).list(labelSelector: @obj_label_selector)
                      else
                        @k8s.client.api(@objapi).resource(@objtype,
                                                          namespace: @objnamespace).list(labelSelector: @obj_label_selector)
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
        hash[:labels] = obj.metadata.labels.to_h
        hash[:annotations] = obj.metadata.annotations.to_h
        hash
      end
    end
  end
end
