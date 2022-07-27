# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_deployment resource to get data about specific kubernetes deployment.
    class K8sDeployments < K8sObjects
      name 'k8s_deployments'
      desc 'Verifies settings for all deployments'

      example "
      describe k8s_deployments(api: 'apps/v1') do
        it { should exist }
        its('names') { should include 'nginx-deployment' }
      end

      describe k8s_deployments(namespace: 'kube-system', api: 'apps/v1') do
        it { should exist }
        its('uids') { should include 'eeb07afc-2f45-4d52-9fda-aa362f7c536c' }
        its('resource_versions') { should include '7944' }
        its('labels') { should include :'k8s-app' => 'kube-dns' }
        its('annotations') { should_not be_empty }
        its('names') { should include 'coredns' }
        its('namespaces') { should include 'kube-system' }
        its('kinds') { should include 'Deployment' }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'deployments'
        super(opts)
      end
    end
  end
end
