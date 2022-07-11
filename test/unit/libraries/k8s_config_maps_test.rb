require_relative '../../test_helper'
require 'k8s_config_maps'

class K8sConfigMapsConstructorTest < Minitest::Test
  def test_empty_param_ok
    assert(Inspec::Resources::K8sConfigMaps.new.exists?)
  end
end

