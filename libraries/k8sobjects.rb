# frozen_string_literal: true

require 'k8s_backend'

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

      def initialize(opts = {})
        # Call the parent class constructor
        super(opts)
        @objapi = opts[:api] if opts[:api] ||= 'v1'
        @objtype = opts[:type] if opts[:type] ||= nil
        @objname = opts[:name] if opts[:name] ||= nil
        @objnamespace = opts[:namespace] if opts[:namespace] ||= nil
        @objlabelSelector = opts[:labelSelector] if opts[:labelSelector] ||= nil
      end

      # FilterTable setup
      filter_table_config = FilterTable.create
      %i[name namespace kind uid resource_version labels annotations].each do |field|
        filter_table_config.add(field, field: field.to_s.pluralize)
      end
      filter_table_config.connect(self, :fetch_data)

      def fetch_data
        catch_k8s_errors do
          getobjects
        end

        return [] unless @k8sobjects

        @table = @k8sobjects.map { |obj| obj.metadata.to_h }
      end

      def getobjects
        if !@objnamespace.nil?
          @k8sobjects = @k8s.client.api(@objapi).resource(@objtype,
                                                          namespace: @objnamespace).list(labelSelector: @objlabelSelector)
        else
          @k8sobjects = @k8s.client.api(@objapi).resource(@objtype).list(labelSelector: @objlabelSelector)
        end
      end

      def items
        entries
      end
    end
  end
end
