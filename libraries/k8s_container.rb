# frozen_string_literal: true

require 'k8sobject'

module Inspec
  module Resources
    # k8s_container resource to get data about specific container in given kubernetes namespace.
    class K8sContainer < K8sObject
      name 'k8s_container'
      desc 'Verifies settings for a specific container'

      example "
      describe k8s_container(namespace: 'my-namespace', pod_name: 'my-pod', name: 'hello-world') do
        it { should exist }
      end
    "

      def initialize(opts = {})
        Validators.validate_params_required(@__resource_name__, [:pod_name, :name], opts)
        opts[:type] = 'pods'
        @container_name = opts[:name]
        opts[:name] = opts[:pod_name]
        super(opts)
        set_resource
      end

      delegate :name, :image, :command, :args, :resources, :volumeMounts, :livenessProbe, :readinessProbe,
               :imagePullPolicy, :securityContext, to: :resource

      def has_volume_mounts?(name, read_only: nil, mount_path: nil)
        return false if volumeMounts.blank?

        volume_mount = volumeMounts.detect do |vm|
          vm.name == name
        end

        return false unless volume_mount

        return false if read_only && volume_mount.readOnly != read_only
        return false if mount_path && volume_mount.mountPath != mount_path

        true
      end

      def has_args?(arg_string)
        return false if args.blank?

        args.include?(arg_string)
      end

      def has_command?(command_string)
        return false if command.blank?

        command.include?(command_string)
      end

      private
      def set_resource
        @k8sobject = @k8sobject.spec.containers.detect{|container| container.name == @container_name }
      end
    end
  end
end

