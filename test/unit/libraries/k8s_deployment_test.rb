# frozen_string_literal: true

require_relative 'resource_test'

class K8sDeploymentTest < ResourceTest
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
  NAME = 'my-deployment'

  def test_uid
    assert_equal('e948355b-adc2-4db8-af16-34f5aa38d6ec', k8s_object.uid)
  end

  def test_resource_version
    assert_equal('8107', k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, { app: 'my-deployment' })
  end

  def test_annotations
    assert_equal(k8s_object.annotations, { 'deployment.kubernetes.io/revision': '1' })
  end

  def test_name
    assert_equal('my-deployment', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('Deployment', k8s_object.kind)
  end

  def test_creation_timestamp
    assert_equal('2022-07-21T18:54:43Z', k8s_object.creation_timestamp)
  end
end
