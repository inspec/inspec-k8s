# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_daemon_set resource to get data about specific kubernetes daemonset.
    class K8sDaemonSet < K8sObject
      name 'k8s_daemon_set'
      desc 'Verifies settings for a specific daemonset'

      example "
      describe k8s_daemon_set(name: 'fluentd-elasticsearch') do
        it { should exist }
        its('uid') { should eq '406b569d-d4f9-4537-b047-cf35b00e88b4' }
        its('resource_version') { should eq '101377' }
        its('labels') { should eq 'k8s-app':'fluentd-logging' }
        its('annotations') { should_not be_empty }
        its('name') { should eq 'fluentd-elasticsearch' }
        its('namespace') { should eq 'default' }
        its('kind') { should eq 'DaemonSet' }
        its('creation_timestamp') { should eq '2022-07-31T16:41:21Z' }
      end

      describe k8s_daemon_set(namespace: 'kube-system', name: 'fluentd-elasticsearch') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'daemonsets'
        opts[:api] = 'apps/v1'
        super(opts)
      end
    end
  end
end
