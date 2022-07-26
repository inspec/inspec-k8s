# frozen_string_literal: true

require_relative 'resource_test'

class K8sConfigMapsConstructorTest < ResourceTest
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

  TYPE = 'configmaps'

  def test_uids
    assert_includes(k8s_objects.uids, 'abcd1234')
  end

  def test_names
    assert_includes(k8s_objects.names, 'configmap1')
  end

  def test_namespaces
    assert_includes(k8s_objects.namespaces, 'default')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'configmap')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, 1234)
  end

  def test_labels
    assert_includes(k8s_objects.labels, {})
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, {})
  end
end
