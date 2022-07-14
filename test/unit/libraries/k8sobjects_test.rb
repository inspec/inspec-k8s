require_relative 'resource_test'

class K8sObjectsTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        pods: [
          {
            name: 'pod1',
            kind: 'pod',
            status: {
              phase: 'running'
            },
            metadata: {
              uid: 'abcd1234',
              name: 'pod1',
              namespace: 'default',
              resourceVersion: 1234,
              annotations: [],
              labels: []
            }
          }
        ]
      }
    }
  }
  TYPE = 'pods'

  def test_uids
    assert_includes('abcd1234', k8s_objects.uids)
  end

  def test_names
    assert_includes('pod1', k8s_objects.names)
  end

  def test_namespaces
    assert_includes('default', k8s_objects.namespaces)
  end

  def test_kinds
    assert_includes('pod', k8s_objects.kinds)
  end

  def test_metadatas
    refute_empty(k8s_objects.metadatas)
  end

  def test_resource_versions
    assert_includes(1234, k8s_objects.resource_versions)
  end

  def test_labels
    assert_empty(k8s_objects.labels)
  end

  def test_annotations
    assert_empty(k8s_objects.annotations)
  end
end
