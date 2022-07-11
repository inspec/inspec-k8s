require_relative '../../test_helper'
require 'k8s_config_map'

class K8sConfigMapConstructorTest < Minitest::Test
  def test_empty_param_not_ok
    assert_raises(ArgumentError) { Inspec::Resources::K8sConfigMap.new }
  end
end
