require_relative '../../test_helper'
require 'k8s_pod'

class K8sPodConstructorTest < Minitest::Test
  def test_empty_param_not_ok
    assert_raises(ArgumentError) { Inspec::Resources::K8sPod.new }
  end
end
