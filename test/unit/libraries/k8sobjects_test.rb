require_relative '../../test_helper'
require 'k8sobjects'

class K8sObjectsTest < Minitest::Test
  stub_data = {
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
  @k8s_objects = Inspec::Resources::K8sObjects.new(
    backend: Mock::K8s::Transport.new(stub_data: stub_data)
  )
  def test_uid
    assert_includes('abcd1234', @k8s_objects.uids)
  end

  def test_name
    assert_includes('pod1', @k8s_objects.names)
  end

  def test_namespace
    assert_includes('default', @k8s_objects.namespaces)
  end

  def test_kind
    assert_includes('pod', @k8s_objects.kinds)
  end

  def test_metadata
    refute_empty(@k8s_objects.metadatas)
  end

  def test_resource_version
    assert_includes(1234, @k8s_objects.resource_versions)
  end

  def test_labels
    assert_empty(@k8s_objects.labels)
  end

  def annotations
    assert_empty(@k8s_objects.annotations)
  end
end
