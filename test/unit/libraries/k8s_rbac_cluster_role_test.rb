require_relative 'resource_test'

class K8sRbacClusterRoleTest < ResourceTest
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
              creationTimestamp: "2022-07-28T10:54:46Z"
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'clusterroles'
  NAME = 'role1'
  NAMESPACE = nil

  def test_uid
    assert_equal('abcd1234', k8s_object.uid)
  end

  def test_kind
    assert_equal('ClusterRole', k8s_object.kind)
  end

  def test_name
    assert_equal('role1', k8s_object.name)
  end

  def test_namespace
    assert_nil(k8s_object.namespace)
  end

  def test_resource_version
    assert_equal(1234, k8s_object.resource_version)
  end

  def test_has_label?
    assert_equal(true, k8s_object.has_label?('label1', 'value1'))
  end

  def test_has_annotation?
    assert_equal(true, k8s_object.has_annotation?('annotation1', 'value1'))
  end

  def test_creation_timestam
    assert_equal("2022-07-28T10:54:46Z", k8s_object.creationTimestamp)
  end

  #TODO: Writing test for rules, aggreation_rule is pending as currently we are unable to call those methods using k8s_object.
  # Need to work on mocking the transport for specific resource.
end