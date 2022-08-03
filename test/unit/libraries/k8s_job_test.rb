# frozen_string_literal: true

require_relative 'resource_test'

class K8sJobTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        jobs: [
          {
            name: 'hello',
            kind: 'Job',
            metadata: {
              uid: '378c1a39-cddc-4df6-bf5a-593779eb26fc',
              name: 'hello',
              namespace: 'default',
              resourceVersion: '1234',
              creationTimestamp: '2022-07-21T10:47:49Z',
              annotations: { 'test_annotation1': 'abc' },
              labels: {}
            }
          }
        ]
      }
    }
  }.freeze

  NAME = 'hello'
  TYPE = 'jobs'

  def test_uid
    assert_equal('378c1a39-cddc-4df6-bf5a-593779eb26fc', k8s_object.uid)
  end

  def test_name
    assert_equal('hello', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('Job', k8s_object.kind)
  end

  def test_resource_version
    assert_equal('1234', k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, {})
  end

  def test_annotations
    assert_equal(k8s_object.annotations, { 'test_annotation1': 'abc' })
  end

  def test_creation_timestamp
    assert_equal('2022-07-21T10:47:49Z', k8s_object.creationTimestamp)
  end
end
