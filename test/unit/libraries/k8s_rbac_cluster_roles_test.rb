# frozen_string_literal: true

require_relative 'resource_test'

class K8sRbacClusterRolesTest < ResourceTest
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
        },
        {
          name: 'role2',
          kind: 'ClusterRole',
          metadata: {
            uid: 'abcd1235',
            name: 'role2',
            resourceVersion: 1235,
            annotations: { annotation1: 'value1' },
            labels: { label1: 'value1' },
            creationTimestamp: '2022-07-28T10:54:46Z'
          },
          aggregationRule: {
            clusterRoleSelectors: [{ foo: 'bar' }]
          }
        }
      ]
    }
  }.freeze

  TYPE = 'clusterroles'
  NAMESPACE = nil

  def test_uids
    assert_includes(k8s_rbac_cluster_roles.uids, 'abcd1234')
  end

  def test_names
    assert_includes(k8s_rbac_cluster_roles.names, 'role1')
  end

  def test_kinds
    assert_includes(k8s_rbac_cluster_roles.kinds, 'ClusterRole')
  end

  def test_resource_versions
    assert_includes(k8s_rbac_cluster_roles.resource_versions, 1234)
  end

  def test_labels
    assert_includes(k8s_rbac_cluster_roles.labels, { label1: 'value1' })
  end

  def test_annotations
    assert_includes(k8s_rbac_cluster_roles.annotations, { annotation1: 'value1' })
  end

  def test_aggregation_rule
    assert_includes(k8s_rbac_cluster_roles.aggregation_rules, { clusterRoleSelectors: [] })
  end

  def test_cluster_role_selectors
    assert_includes(k8s_rbac_cluster_roles.cluster_role_selectors, { foo: 'bar' })
  end

  def test_rules
    assert_includes(k8s_rbac_cluster_roles.rules, { verbs: %w[get list watch] })
  end
end
