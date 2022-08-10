# frozen_string_literal: true

# Mock for K8s API Client / Transport
require 'ostruct'
require 'json'

module Mock
  module K8s
    class Transport
      # @param stub_data structured k8s API response formatted for our test cases
      # @example stub_data: {
      #         'v1': {
      #           namespace: {
      #             pods: [
      #               ...
      #             ]
      #           }
      #         }
      #       }
      def initialize(stub_data: {}, raise_errors: true)
        @stub_data = JSON.parse(stub_data.to_json, object_class: OpenStruct)
        @api_version = 'v1'
        @type = nil
        @namespace = 'default'
        @raise_errors = raise_errors
      end

      # @param name specific resource name
      def get(name = nil)
        raise ArgumentError if raise_errors && !name

        current_data.select { |data| data.name == name }.first
      end

      # @note expand it if we need stubs specifically for any attributes like labels
      def list(*)
        current_data
      end

      def backend
        self
      end

      def client
        self
      end

      def api(api_version)
        @api_version = api_version
        self
      end

      # namespace_hash has the key :namespace its value.
      # if namespace is nil then the hash is empty.
      def resource(type, namespace_hash = {})
        @type = type
        @namespace = namespace_hash[:namespace]
        self
      end

      def api_resources
        [stub_data]
      end

      private

      attr_reader :stub_data, :api_version, :type, :namespace, :raise_errors

      def current_data
        if namespace.nil?
          stub_data.send(api_version).send(type) || {}
        else
          stub_data.send(api_version).send(namespace).send(type) || {}
        end
      end
    end
  end
end
