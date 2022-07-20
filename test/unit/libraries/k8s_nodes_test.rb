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
              labels: { "foo" => "bar"}
            }
          },
          {
            name: 'node2',
            kind: 'node',
            metadata: {
              uid: 'abcd4567',
              name: 'node2',
              resourceVersion: 4321,
              annotations: {foo: 'bar'},
              labels: {}
            }
          }
        ]
      }
    }
  }

  TYPE = 'nodes'.freeze

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

  # This needs to be modified once the issue for labels and annotation is fixed in the dependent PR
  # def test_labels
  #   assert_empty(k8s_objects.labels.flatten)
  # end

  # def test_annotations
  #   assert_empty(k8s_objects.annotations.flatten)
  # end
end