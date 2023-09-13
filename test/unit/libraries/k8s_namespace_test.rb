# frozen_string_literal: true

require_relative 'resource_test'

class K8sNamespaceTest < ResourceTest
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
  NAME = 'kube-node-lease'

  def test_uid
    assert_equal('5ed76d62-838b-45cb-b41f-789b567a2fa2', k8s_object.uid)
  end

  def test_name
    assert_equal('kube-node-lease', k8s_object.name)
  end

  def test_kind
    assert_equal('Namespace', k8s_object.kind)
  end

  def test_resource_version
    assert_equal('6', k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, { 'kubernetes.io/metadata.name': 'kube-node-lease' })
  end

  def test_creation_timestamp
    assert_equal(k8s_object.creationTimestamp, '2022-07-21T10:47:49Z')
  end

  def test_resource_id
    refute_nil(k8s_object.resource_id)
  end
end
