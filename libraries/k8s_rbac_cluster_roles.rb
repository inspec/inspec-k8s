# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_rbac_cluster_roles resource to get data about all Kubernetes RBAC cluster roles
    class K8sRbacClusterRoles < K8sObjects
      DEFAULT_NAMESPACE = nil

      name 'k8s_rbac_cluster_roles'
      desc 'Verifies settings for all RBAC cluster roles'

      example "
      describe k8s_rbac_cluster_roles do
        it { should exist }
        its('names') { should include 'cluster-role-name' }
        its('uids') { should include '6a1a4d2f-0953-4115-8564-acd7bb63a786'}
        ...
      end
    "

      def initialize(opts = {})
        opts[:type] = 'clusterroles'
        opts[:api] = 'rbac.authorization.k8s.io/v1'
        super(opts)
      end

      private

      def build_record_from(obj)
        hash = {
          rules: obj&.rules&.map(&:to_h),
          aggregation_rule: obj&.aggregationRule&.to_h,
          cluster_role_selectors: obj&.aggregationRule&.clusterRoleSelectors&.map(&:to_h)
        }
        super.merge!(hash)
      end
    end
  end
end
