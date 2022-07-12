require_relative '../../test_helper'
require 'k8sobject'

class K8sObjectTest < Minitest::Test
  stub_data = {
    'v1': {
      default: {
        pods: [
          {
            name: 'pod1',
            kind: 'pod',
            status: {
              phase: 'running'
            },
            metadata: {
              uid: 'abcd1234',
              name: 'pod1',
              namespace: 'default',
              resourceVersion: 1234,
              annotations: [],
              labels: []
            }
          }
        ]
      }
    }
  }
  @k8s_object = Inspec::Resources::K8sObject.new(backend: Mock::K8s::Transport.new(stub_data: stub_data))
  def test_uid
    assert_equal('abcd1234', @k8s_object.uid)
  end
end
