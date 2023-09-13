# frozen_string_literal: true

require_relative 'resource_test'

class K8sNamespacesTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        namespaces: [
          {
            name: 'kube-node-lease',
            kind: 'Namespace',
            metadata: {
              uid: '5ed76d62-838b-45cb-b41f-789b567a2fa2',
              name: 'kube-node-lease',
              creationTimestamp: '2022-07-21T10:47:49Z',
              resourceVersion: '6',
              labels: { 'kubernetes.io/metadata.name' => 'kube-node-lease' }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'namespaces'

  def test_uids
    assert_includes(k8s_objects.uids, '5ed76d62-838b-45cb-b41f-789b567a2fa2')
  end

  def test_names
    assert_includes(k8s_objects.names, 'kube-node-lease')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'Namespace')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, '6')
  end

  def test_labels
    assert_includes(k8s_objects.labels, { 'kubernetes.io/metadata.name': 'kube-node-lease' })
  end

  def test_resource_id
    refute_nil(k8s_objects.resource_id)
  end
end
