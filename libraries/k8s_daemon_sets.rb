# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_daemon_sets resource to get data about all kubernetes daemonsets.
    class K8sDaemonSets < K8sObjects
      name 'k8s_daemon_sets'
      desc 'Verifies settings for all daemonsets'

      example "
      describe k8s_daemon_sets do
        it { should exist }
        its('names') { should include 'fluentd-elasticsearch' }
        its('resource_versions') { should include '101377' }
        its('labels') { should include 'k8s-app':'fluentd-logging' }
        its('annotations') { should_not be_empty }
        its('uids') { should include '406b569d-d4f9-4537-b047-cf35b00e88b4' }
        its('namespaces') { should include 'default' }
        its('kinds') { should include 'DaemonSet' }
      end

      describe k8s_daemon_sets(namespace: 'kube-system') do
        it { should exist }
        its('names') { should include 'fluentd-elasticsearch' }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'daemonsets'
        opts[:api] = 'apps/v1'
        super(opts)
      end
    end
  end
end
