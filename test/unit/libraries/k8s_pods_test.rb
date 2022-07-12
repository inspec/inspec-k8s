require_relative '../../test_helper'
require 'k8s_pods'

class K8sPodsConstructorTest < Minitest::Test
  def test_empty_param_ok
    assert(Inspec::Resources::K8sPods.new.exists?)
  end
end
