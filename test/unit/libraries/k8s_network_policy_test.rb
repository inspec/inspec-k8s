# frozen_string_literal: true

require_relative 'resource_test'

class K8sNetworkPolicyTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        networkpolicies: [
          {
            name: 'my-network-policy',
            kind: 'NetworkPolicy',
            metadata: {
              uid: '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6',
              name: 'my-network-policy',
              namespace: 'default',
              resourceVersion: '129558',
              creationTimestamp: '2022-08-02T09:47:56Z',
              annotations: {
                'kubectl.kubernetes.io/last-applied-configuration': '{apiVersion: \'networking.k8s.io/v1\'}'
              },
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'networkpolicies'
  NAME = 'my-network-policy'

  def test_uid
    assert_equal('0beb1fc6-8af7-4607-b3c0-2bff65d4abd6', k8s_object.uid)
  end

  def test_resource_version
    assert_equal('129558', k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, {})
  end

  def test_annotations
    assert_equal(k8s_object.annotations,
                 { 'kubectl.kubernetes.io/last-applied-configuration': '{apiVersion: \'networking.k8s.io/v1\'}' })
  end

  def test_name
    assert_equal('my-network-policy', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('NetworkPolicy', k8s_object.kind)
  end

  def test_creation_timestamp
    assert_equal('2022-08-02T09:47:56Z', k8s_object.creation_timestamp)
  end
end
