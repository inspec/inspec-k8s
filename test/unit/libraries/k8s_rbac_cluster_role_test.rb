# frozen_string_literal: true

require_relative 'resource_test'

class K8sRbacClusterRoleTest < ResourceTest
  STUB_DATA = {
    'rbac.authorization.k8s.io/v1': {
      clusterroles: [
        {
          name: 'role1',
          kind: 'ClusterRole',
          metadata: {
            uid: 'abcd1234',
            name: 'role1',
            resourceVersion: 1234,
            annotations: { annotation1: 'value1' },
            labels: { label1: 'value1' },
            creationTimestamp: '2022-07-28T10:54:46Z'
          },
          rules: [
            { verbs: ['get', 'list', 'watch'] }
          ],
          aggregationRule: {
            clusterRoleSelectors: []
          }
        }
      ]
    }
  }.freeze

  TYPE = 'clusterroles'
  NAME = 'role1'
  NAMESPACE = nil

  def test_uid
    assert_equal('abcd1234', k8s_rbac_cluster_role.uid)
  end

  def test_kind
    assert_equal('ClusterRole', k8s_rbac_cluster_role.kind)
  end

  def test_name
    assert_equal('role1', k8s_rbac_cluster_role.name)
  end

  def test_namespace
    assert_nil(k8s_rbac_cluster_role.namespace)
  end

  def test_resource_version
    assert_equal(1234, k8s_rbac_cluster_role.resource_version)
  end

  def test_has_label?
    assert_equal(true, k8s_rbac_cluster_role.has_label?('label1', 'value1'))
  end

  def test_has_annotation?
    assert_equal(true, k8s_rbac_cluster_role.has_annotation?('annotation1', 'value1'))
  end

  def test_creation_timestam
    assert_equal('2022-07-28T10:54:46Z', k8s_rbac_cluster_role.creationTimestamp)
  end

  def test_aggregation_rule
    assert_equal({ clusterRoleSelectors: [] }, k8s_rbac_cluster_role.aggregation_rule)
  end

  def test_cluster_role_selectors
    assert_equal([], k8s_rbac_cluster_role.cluster_role_selectors)
  end

  def test_rules
    assert_equal([{ verbs: %w[get list watch] }], k8s_rbac_cluster_role.rules)
  end

  def test_resource_id
    refute_nil(k8s_rbac_cluster_role.resource_id)
  end
end
