# frozen_string_literal: true

require 'k8s_backend'
require 'pry'

module Inspec::Resources
  class K8sVersion < K8sResourceBase
    name 'k8sversion'
    desc 'Gets Kubernetes Version info'

    example "
      describe k8sversion() do
        its('name') { should eq 'my-pod' }
        ...
      end
    "
    attr_reader :k8sversion, :k8suri, :gitVersion, :major, :minor, :platform, :buildDate

    def initialize(opts = {})
      # Call the parent class constructor
      super(opts)

      catch_k8s_errors do
        @k8suri = @k8s.uri
        @k8sversion = @k8s.client.version
      end
      @gitVersion = @k8sversion[:gitVersion]
      @major = @k8sversion[:major]
      @minor = @k8sversion[:minor]
      @platform = @k8sversion[:platform]
      @buildDate = @k8sversion[:buildDate]
    end

    def platform
      return 'aks' if @k8suri =~ /azmk8s\.io:/
      return 'gke' if @gitVersion =~ /gke/
      return 'eks' if @gitVersion =~ /eks/

      'k8s'
    end

    def exists?
      !@k8sversion.nil?
    end

    def to_s
      @display_name.to_s
    end
  end
end
