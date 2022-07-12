# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    class K8sPods < K8sObjects
      name 'k8s_config_maps'
      desc 'Verifies settings for all config maps'

      example "
      describe k8s_pods(namespace: 'default') do
        it { should exist }
        its('name') { should eq 'my-pod' }
        ...
      end
    "

      def initialize(opts = {})
        @objtype = 'pods'
        super(opts)
      end
    end
  end
end
