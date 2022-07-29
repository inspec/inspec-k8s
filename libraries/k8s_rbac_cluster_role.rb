# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_rbac_cluster_role resource to get data about specific kubernetes cluster role.
    class K8sRbacClusterRole < K8sObject
      DEFAULT_NAMESPACE = nil

      name 'k8s_rbac_cluster_role'
      desc 'Verifies RBAC cluster role values for secified cluster role.'

      example "
      describe k8s_rbac_cluster_role(name: 'cluster-role-name') do
        it { should exist }
        its('name') { should eq 'cluster-role-name' }
        ...
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:name], opts)
        opts[:type] = 'clusterroles'
        opts[:api] = 'rbac.authorization.k8s.io/v1'
        super(opts)
      end

      def aggregation_rule
        resource.aggregationRule.to_h
      end

      def cluster_role_selectors
        return [] if resource.aggregationRule.nil?

        resource.aggregationRule.clusterRoleSelectors.map(&:to_h)
      end

      def rules
        return [] if resource.rules.nil?

        resource.rules.map(&:to_h)
      end
    end
  end
end
