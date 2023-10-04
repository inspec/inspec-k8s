# frozen_string_literal: true

require_relative 'resource_test'

class K8sObjectTest < ResourceTest
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
              annotations: { test_annotation1: 'abc' },
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze
  NAME = 'pod1'
  TYPE = 'pods'

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
    assert_equal({}, k8s_object.labels)
  end

  def test_has_label?
    assert_equal(false, k8s_object.has_label?('foo', 'bar'))
  end

  def test_has_annotation?
    assert_equal(true, k8s_object.has_annotation?('test_annotation1', 'abc'))
  end

  def test_has_annotation_only_key
    assert_equal(true, k8s_object.has_annotation?('test_annotation1'))
  end

  def test_resource_id
    assert_equal('abcd1234', k8s_object.resource_id)
  end

  def resource_id
    retute_nil(k8s_object.resource_id)
  end
end
