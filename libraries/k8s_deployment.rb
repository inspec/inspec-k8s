# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_deployment resource to get data about specific kubernetes deployment.
    class K8sDeployment < K8sObject
      name 'k8s_deployment'
      desc 'Verifies settings for a specific deployment'

      example "
      describe k8s_deployment(name: 'my-deployment', api: 'apps/v1') do
        it { should exist }
        its('name') { should eq 'my-deployment' }
      end

      describe k8s_deployment(namespace: 'default', name: 'new-deployment', api: 'apps/v1') do
        it { should exist }
        its('uid') { should eq 'e948355b-adc2-4db8-af16-34f5aa38d6ec' }
        its('resourceVersion') { should eq '8107' }
        its('labels') { should eq :app=>'new-deployment' }
        its('annotations') { should_not be_empty }
        its('name') { should eq 'new-deployment' }
        its('namespace') { should eq 'default' }
        its('kind') { should eq 'Deployment' }
        its('creation_timestamp') { should eq '2022-07-21T18:54:43Z' }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'deployments'
        super(opts)
      end
    end
  end
end
