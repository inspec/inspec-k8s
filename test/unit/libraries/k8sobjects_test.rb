require_relative '../../test_helper'
require 'k8sobject'

class K8sObjectsConstructorTest < Minitest::Test
  def test_empty_param_not_ok
    assert_raises(ArgumentError) { Inspec::Resources::K8sObjects.new }
  end
end


