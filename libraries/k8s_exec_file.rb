# frozen_string_literal: true
require 'train-kubernetes/file/linux'
require 'inspec/resources/file'

module Inspec
  module Resources
    class K8sExecFile < ::Inspec::Resources::FileResource
      attr_reader :opts

      name 'k8s_exec_file'
      supports platform: 'k8s'
      desc 'Run a command or script inside a pod.'

      example <<~EXAMPLE
        describe k8s_exec_file(path: '/etc/e2scrub.conf', pod: 'shell-demo', namespace: 'default') do
          it { should exist }
          it { should be_file }
          it { should be_readable }
          it { should be_writable }
          it { should be_executable.by_user('root') }
          it { should be_owned_by 'root' }
          its('mode') { should cmp '0644' }
        end
      EXAMPLE

      def initialize(opts)
        @opts = opts
        @path = opts[:path]
        @pod = opts[:pod]
        @container = opts[:container]
        @namespace = opts[:namespace]
        Validators.validate_params_required(@__resource_name__, %i[pod path], opts)
        @file = inspec.backend.file(path, pod: pod, container: container, namespace: namespace)
        @perms_provider = ::Inspec::Resources::UnixFilePermissions.new(inspec)
      end

      private

      attr_reader :pod, :container, :namespace, :path
    end
  end
end

