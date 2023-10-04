# frozen_string_literal: true

require_relative 'resource_test'

class K8sNetworkPoliciesTest < ResourceTest
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

  def test_uids
    assert_includes(k8s_objects.uids, '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, '129558')
  end

  def test_labels
    assert_includes(k8s_objects.labels, {})
  end

  def test_annotations
    assert_includes(k8s_objects.annotations,
                    { 'kubectl.kubernetes.io/last-applied-configuration': '{apiVersion: \'networking.k8s.io/v1\'}' })
  end

  def test_names
    assert_includes(k8s_objects.names, 'my-network-policy')
  end

  def test_namespaces
    assert_includes(k8s_objects.namespaces, 'default')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'NetworkPolicy')
  end

  def test_resource_id
    refute_nil(k8s_objects.resource_id)
  end
end
