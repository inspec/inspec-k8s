# frozen_string_literal: true

require_relative 'resource_test'

class K8sCronjobsTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        cronjobs: [
          {
            name: 'hello',
            kind: 'Cronjob',
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

  TYPE = 'cronjobs'

  def test_uids
    assert_includes(k8s_objects.uids, '378c1a39-cddc-4df6-bf5a-593779eb26fc')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, '1234')
  end

  def test_labels
    assert_includes(k8s_objects.labels, {})
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, { 'test_annotation1': 'abc' })
  end

  def test_names
    assert_includes(k8s_objects.names, 'hello')
  end

  def test_namespaces
    assert_includes(k8s_objects.namespaces, 'default')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'Cronjob')
  end

  def test_resource_id
    refute_nil(k8s_objects.resource_id)
  end
end
