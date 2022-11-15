# # frozen_string_literal: true
require 'train-kubernetes/kubectl_client'
require 'inspec/resources/command'
module Inspec
  module Resources
    class K8sPodExec < ::Inspec::Resources::Cmd
      attr_reader :opts

      name 'k8s_pod_exec'
      supports platform: 'k8s'
      desc 'Run a command or script inside a pod.'

      example <<~EXAMPLE
        describe k8s_pod_exec(command: 'whoami', pod: 'nginx', namespace: 'default') do
          its('stdout') { should match /root/ }
          its('stderr') { should eq '' }
          its('exit_status') { should eq 0 }
        end
      EXAMPLE

      def initialize(opts)
        @opts = opts
        @pod = opts[:pod]
        @container = opts[:container]
        @namespace = opts[:namespace]
        @command = opts[:command]
        Validators.validate_params_required(@__resource_name__, %i[pod command], opts)
        super(command, pod: pod, container: container, namespace: namespace)
      end

      def result
        return @result if defined?(@result)

        inspec.backend.run_command(command, { pod: pod, container: container, namespace: namespace, timeout: @timeout })
      rescue Train::CommandTimeoutReached
        # Without a small sleep, the train connection gets broken
        # We've already timed out, so a small sleep is not likely to be painful here.
        sleep 0.1
        raise Inspec::Exceptions::ResourceFailed,
              "Command `#{command}` timed out after #{@timeout} seconds"
      end

      private

      attr_reader :pod, :container, :namespace, :command
    end
  end
end
