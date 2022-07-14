module Shared
  module Examples
    NAMESPACE = 'default'.freeze

    def k8s_object
      @k8s_object ||= Inspec::Resources::K8sObject.new(
        backend: Mock::K8s::Transport.new(stub_data: self.class::STUB_DATA),
        name: self.class::NAME,
        type: self.class::TYPE,
        namespace: self.class::NAMESPACE
      )
    end
  end
end