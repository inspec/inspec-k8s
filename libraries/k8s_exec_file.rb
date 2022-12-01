# frozen_string_literal: true

require 'inspec/resources/file'
require 'train-kubernetes/file/linux_permissions'
require 'train-kubernetes/file/linux_immutable_file_check'
require 'inspec/utils/parser'

module Inspec
  module Resources
    class K8sExecFile < ::Inspec::Resources::FileResource
      include ::Inspec::Utils::LinuxMountParser
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
        @perms_provider = ::TrainPlugins::TrainKubernetes::File::LinuxPermissions.new(inspec,
                                                                                      pod: pod,
                                                                                      container: container,
                                                                                      namespace: namespace)
      end

      def immutable?
        file_info = ::TrainPlugins::TrainKubernetes::File::LinuxImmutableFileCheck.new(inspec,
                                                                                       file,
                                                                                       pod: pod,
                                                                                       container: container,
                                                                                       namespace: namespace)
        file_info.is_immutable?
      end

      def mounted?(expected_options = nil, identical = false)
        mounted = file.mounted

        # return if no additional parameters have been provided
        return file.mounted? if expected_options.nil?

        # parse content if we are on linux
        @mount_options ||= parse_mount_options(mounted.stdout, true)

        if identical
          # check if the options should be identical
          @mount_options == expected_options
        else
          # otherwise compare the selected values
          @mount_options.contains(expected_options)
        end
      end

      private

      attr_reader :pod, :container, :namespace, :path, :file
    end
  end
end
