# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_job resource to get data about specific job in given kubernetes namespace.
    class K8sJob < K8sObject
      name 'k8s_job'
      desc 'Verifies settings for a specific job'

      example "
      describe k8s_job(name: 'pi') do
        it { should exist }
        its('uid') { should eq 'a31e4d72-816d-4678-8cda-34973bc7808b' }
        its('resource_version') { should eq '818' }
        its('labels') { should_not be_empty }
        its('annotations') { should_not be_empty }
        its('name') { should eq 'pi' }
        its('namespace') { should eq 'default' }
        its('kind') { should eq 'Job' }
        its('creation_timestamp') { should eq '2022-08-02T12:05:40Z' }
      end

      describe k8s_job(name: 'hello-world', namespace: 'my-namespace') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'jobs'
        opts[:api] = 'batch/v1'
        super(opts)
      end
    end
  end
end
