require_relative 'resource_test'

class K8sNodeTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        nodes: [
          {
            name: 'node1',
            kind: 'node',
            metadata: {
              uid: 'abcd1234',
              name: 'node1',
              resourceVersion: 1234,
              annotations: { annotation1: "value1" },
              labels: { label1: "value1" }
            }
          }
        ]
      }
    }
  }

  TYPE = 'nodes'.freeze
  NAME = 'node1'.freeze

  def test_uid
    assert_equal('abcd1234', k8s_object.uid)
  end

  def test_name
    assert_equal('node1', k8s_object.name)
  end

  def test_namespace
    assert_nil(k8s_object.namespace)
  end

  def test_kind
    assert_equal('node', k8s_object.kind)
  end

  def test_resource_version
    assert_equal(1234, k8s_object.resource_version)
  end

  def test_has_label?
    assert_equal(true, k8s_object.has_label?("label1", "value1"))
  end

  def test_has_annotation?
    assert_equal(true, k8s_object.has_annotation?("annotation1", "value1"))
  end
end