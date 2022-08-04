# frozen_string_literal: true

require 'k8sobject'
require 'k8sobjects'
require 'k8s_rbac_cluster_role'
require 'k8s_rbac_cluster_roles'

module Shared
  module Examples
    NAMESPACE = 'default'

    def k8s_object
      @k8s_object ||= Inspec::Resources::K8sObject.new(
        backend: Mock::K8s::Transport.new(stub_data: self.class::STUB_DATA),
        name: self.class::NAME,
        type: self.class::TYPE,
        namespace: self.class::NAMESPACE
      )
    end

    def k8s_objects
      @k8s_objects ||= Inspec::Resources::K8sObjects.new(
        backend: Mock::K8s::Transport.new(stub_data: self.class::STUB_DATA),
        type: self.class::TYPE,
        namespace: self.class::NAMESPACE
      )
    end

    def k8s_rbac_cluster_role
      @k8s_rbac_cluster_role ||= Inspec::Resources::K8sRbacClusterRole.new(
        backend: Mock::K8s::Transport.new(stub_data: self.class::STUB_DATA),
        name: self.class::NAME,
        type: self.class::TYPE,
        namespace: self.class::NAMESPACE
      )
    end

    def k8s_rbac_cluster_roles
      @k8s_rbac_cluster_roles ||= Inspec::Resources::K8sRbacClusterRoles.new(
        backend: Mock::K8s::Transport.new(stub_data: self.class::STUB_DATA),
        type: self.class::TYPE,
        namespace: self.class::NAMESPACE
      )
    end
  end
end
