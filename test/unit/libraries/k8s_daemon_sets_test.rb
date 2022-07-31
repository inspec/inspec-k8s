# frozen_string_literal: true

require_relative 'resource_test'

class K8sDaemonSetsTest < ResourceTest
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
              annotations: { 'deprecated.daemonset.template.generation': '1' },
              labels: { 'k8s-app': 'fluentd-logging' }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'daemonsets'

  def test_uids
    assert_includes(k8s_objects.uids, 'b7dace1e-138a-4527-ad15-86674f52b609')
  end

  def test_resource_versions
    assert_includes(k8s_objects.resource_versions, '40328')
  end

  def test_labels
    assert_includes(k8s_objects.labels, { 'k8s-app': 'fluentd-logging' })
  end

  def test_annotations
    assert_includes(k8s_objects.annotations, { 'deprecated.daemonset.template.generation': '1' })
  end

  def test_names
    assert_includes(k8s_objects.names, 'fluentd-elasticsearch')
  end

  def test_namespaces
    assert_includes(k8s_objects.namespaces, 'default')
  end

  def test_kinds
    assert_includes(k8s_objects.kinds, 'DaemonSet')
  end
end
