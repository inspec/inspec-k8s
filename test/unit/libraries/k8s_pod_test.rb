# frozen_string_literal: true

require_relative 'resource_test'

class K8sPodTest < ResourceTest
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
              annotations: {},
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'pods'
  NAME = 'pod1'

  def test_uid
    assert_equal('abcd1234', k8s_object.uid)
  end

  def test_name
    assert_equal('pod1', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('pod', k8s_object.kind)
  end

  def test_resource_version
    assert_equal(1234, k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, {})
  end

  def test_annotations
    assert_equal(k8s_object.annotations, {})
  end

  def test_resource_id
    refute_nil(k8s_object.resource_id)
  end
end
