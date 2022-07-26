# frozen_string_literal: true

require_relative 'resource_test'

class K8sConfigMapTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        configmaps: [
          {
            name: 'configmap1',
            kind: 'configmap',
            status: {
              phase: 'running'
            },
            metadata: {
              uid: 'abcd1234',
              name: 'configmap1',
              namespace: 'default',
              resourceVersion: 1234,
              annotations: {},
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze

  NAME = 'configmap1'
  TYPE = 'configmaps'

  def test_uid
    assert_equal('abcd1234', k8s_object.uid)
  end

  def test_name
    assert_equal('configmap1', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('configmap', k8s_object.kind)
  end

  def test_resource_version
    assert_equal(1234, k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, {})
  end

  def annotations
    assert_equal(k8s_object.annotations, {})
  end
end
