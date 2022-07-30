# frozen_string_literal: true

require_relative 'resource_test'

class K8sRbacClusterRolesTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
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
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'clusterroles'
  NAMESPACE = nil

  def test_uids
    assert_includes(k8s_objects.uids, 'abcd1234')
  end

  def test_names
    assert_includes(k8s_objects.names, 'role1')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'ClusterRole')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, 1234)
  end

  def test_labels
    assert_includes(k8s_objects.labels, { label1: 'value1' })
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, { annotation1: 'value1' })
  end

  # TODO: Writing test for rules, aggreation_rule is pending as currently we are unable to call those methods
  # using k8s_object. Need to work on mocking the transport for specific resource.
end
