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

      def initialize(opts = {})
        opts[:type] = 'configmaps'
        super(opts)
      end

      private

      def build_record_from(obj)
        super.merge!(data: obj.data.to_h)
      end
    end
  end
end
