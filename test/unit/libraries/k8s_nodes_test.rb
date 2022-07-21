# frozen_string_literal: true

require_relative 'resource_test'

class K8sNodesTest < ResourceTest
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
              namespace: 'default',
              resourceVersion: 1234,
              annotations: {},
              labels: { foo: 'bar' }
            }
          },
          {
            name: 'node2',
            kind: 'node',
            metadata: {
              uid: 'abcd4567',
              name: 'node2',
              resourceVersion: 4321,
              annotations: { foo1: 'bar1' },
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'nodes'

  def test_uids
    assert_includes(k8s_objects.uids, 'abcd1234')
  end

  def test_names
    assert_includes(k8s_objects.names, 'node2')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'node')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, 4321)
  end

  def test_labels
    assert_includes(k8s_objects.labels, { foo: 'bar' })
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, {})
  end

  def test_annotations_has_given_values
    assert_includes(k8s_objects.annotations, { foo1: 'bar1' })
  end
end
