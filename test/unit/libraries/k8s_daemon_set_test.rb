# frozen_string_literal: true

require_relative 'resource_test'

class K8sDaemonSetTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        daemonsets: [
          {
            name: 'fluentd-elasticsearch',
            kind: 'DaemonSet',
            metadata: {
              uid: 'b7dace1e-138a-4527-ad15-86674f52b609',
              name: 'fluentd-elasticsearch',
              namespace: 'default',
              resourceVersion: '40328',
              creationTimestamp: '2022-07-21T18:54:43Z',
              annotations: { 'deprecated.daemonset.template.generation': '1' },
              labels: { 'k8s-app': 'fluentd-logging' }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'daemonsets'
  NAME = 'fluentd-elasticsearch'

  def test_uid
    assert_equal('b7dace1e-138a-4527-ad15-86674f52b609', k8s_object.uid)
  end

  def test_resource_version
    assert_equal('40328', k8s_object.resource_version)
  end

  def test_labels
    assert_equal(k8s_object.labels, { 'k8s-app': 'fluentd-logging' })
  end

  def test_annotations
    assert_equal(k8s_object.annotations, { 'deprecated.daemonset.template.generation': '1' })
  end

  def test_name
    assert_equal('fluentd-elasticsearch', k8s_object.name)
  end

  def test_namespace
    assert_equal('default', k8s_object.namespace)
  end

  def test_kind
    assert_equal('DaemonSet', k8s_object.kind)
  end

  def test_creation_timestamp
    assert_equal('2022-07-21T18:54:43Z', k8s_object.creation_timestamp)
  end
end
