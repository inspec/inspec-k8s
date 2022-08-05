# frozen_string_literal: true

require_relative 'resource_test'

class K8sApiResourcesTest < ResourceTest
  STUB_DATA = {
    name: 'daemonsets',
    singularName: '',
    namespaced: true,
    group: 'autoscaling',
    version: 'v1',
    kind: 'DaemonSet',
    shortNames: ['ds'],
    categories: ['all']
  }.freeze

  API = 'apps/v1'

  def test_name
    assert_equal(['daemonsets'], k8s_api_resources.name)
  end

  def test_singular_name
    assert_equal([''], k8s_api_resources.singularName)
  end

  def test_namespaced
    assert_equal([true], k8s_api_resources.namespaced)
  end

  def test_group
    assert_equal(['autoscaling'], k8s_api_resources.group)
  end

  def test_version
    assert_equal(['v1'], k8s_api_resources.version)
  end

  def test_kind
    assert_equal(['DaemonSet'], k8s_api_resources.kind)
  end

  def test_short_names
    assert_equal(['ds'], k8s_api_resources.shortNames)
  end

  def test_categories
    assert_equal(['all'], k8s_api_resources.categories)
  end
end
