# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_cronjob resource to get data about specific cronjob in given kubernetes namespace.
    class K8sCronjob < K8sObject
      name 'k8s_cronjob'
      desc 'Verifies settings for a specific cronjob'

      example "
      describe k8s_cronjob(name: 'hello') do
        it { should exist }
        its('uid') { should eq '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
        its('resource_version') { should eq '70517' }
        its('labels') { should be_empty }
        its('annotations') { should_not be_empty }
        its('name') { should eq 'hello' }
        its('namespace') { should eq 'default' }
        its('kind') { should eq 'CronJob' }
        its('creationTimestamp') { should eq '2022-07-27T12:54:44Z' }
      end

      describe k8s_cronjob(name: 'hello-world', namespace: 'my-namespace') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'cronjobs'
        opts[:api] = 'batch/v1'
        super(opts)
      end
    end
  end
end
