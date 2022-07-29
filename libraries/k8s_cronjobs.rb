# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_cronjobs resource to get data about all kubernetes cronjobs.
    class K8sCronjobs < K8sObjects
      name 'k8s_cronjobs'
      desc 'Verifies settings for all cronjobs'

      example "
      describe k8s_cronjobs do
        it { should exist }
        its('names') { should include 'hello' }
        its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
      end

      describe k8s_cronjobs(namespace: 'my-namespace') do
        it { should exist }
        its('names') { should include 'hello-world' }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'cronjobs'
        opts[:api] = 'batch/v1'
        super(opts)
      end
    end
  end
end
