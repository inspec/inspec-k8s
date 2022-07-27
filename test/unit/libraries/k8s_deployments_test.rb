# frozen_string_literal: true

require_relative 'resource_test'

class K8sPodsTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        deployments: [
          {
            name: 'my-deployment',
            kind: 'Deployment',
            metadata: {
              uid: 'e948355b-adc2-4db8-af16-34f5aa38d6ec',
              name: 'my-deployment',
              namespace: 'default',
              resourceVersion: '8107',
              creationTimestamp: '2022-07-21T18:54:43Z',
              annotations: { 'deployment.kubernetes.io/revision': '1' },
              labels: { app: 'my-deployment' }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'deployments'

  def test_uids
    assert_includes(k8s_objects.uids, 'e948355b-adc2-4db8-af16-34f5aa38d6ec')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, '8107')
  end

  def test_labels
    assert_includes(k8s_objects.labels, { app: 'my-deployment' })
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, { 'deployment.kubernetes.io/revision': '1' })
  end

  def test_names
    assert_includes(k8s_objects.names, 'my-deployment')
  end

  def test_namespaces
    assert_includes(k8s_objects.namespaces, 'default')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'Deployment')
  end
end
