# frozen_string_literal: true

require 'k8s_backend'
require 'pry'
require 'active_support/core_ext/module/delegation'

module Inspec
  module Resources
    # k8s_object resource class to get information about all types of Kubernetes resources.
    class K8sObject < K8sResourceBase
      DEFAULT_NAMESPACE = 'default'
      name 'k8sobject'
      desc 'Verifies settings for a single resource'

      example "
      describe k8sobject(api: 'v1', type: 'pod', namespace: 'default', name: 'my-pod') do
        it { should exist }
        its('name') { should eq 'my-pod' }
        ...
      end
    "
      attr_reader :k8sobject

      def initialize(opts = {})
        # Call the parent class constructor
        super(opts)

        @objapi = opts[:api] if opts[:api] ||= 'v1'
        @objtype = opts[:type] if opts[:type] ||= nil
        @objname = opts[:name] if opts[:name] ||= nil
        @objnamespace = opts[:namespace] ||= self.class::DEFAULT_NAMESPACE

        @display_name = if !@objnamespace.nil?
                          "#{@objnamespace}/#{@objname}"
                        else
                          @objname.to_s
                        end
        catch_k8s_errors do
          @k8sobject = if !@objnamespace.nil?
                         @k8s.client.api(@objapi).resource(@objtype, namespace: @objnamespace).get(@objname)
                       else
                         @k8s.client.api(@objapi).resource(@objtype).get(@objname)
                       end
        end
      end

      delegate :kind, :metadata, to: :resource
      delegate :uid, :name, :namespace, :resourceVersion, :creationTimestamp, to: :metadata

      alias resource_version resourceVersion
      alias creation_timestamp creationTimestamp

      def item
        @k8sobject
      end

      def container_names
        if @k8sobject.respond_to?(:spec) && @k8sobject.spec.respond_to?(:containers) && @k8sobject.spec.containers.respond_to?(:name)
          @k8sobject.spec.containers.map(&:name)
        end
      end

      def container_images
        @k8sobject.spec.containers&.map(&:image)
      end

      def has_latest_container_tag?
        if @k8sobject.respond_to?(:spec) && @k8sobject.spec.respond_to?(:containers)
          @k8sobject.spec.containers.map(&:image).each do |i|
            return true if i =~ /^.*:latest$/
          end
        end
        false
      end

      def has_label?(objlabel = nil, value = nil)
        # Earlier only key was verified. Accepting value as nil just for the backward compatibility.
        if value.nil?
          @k8sobject&.metadata&.labels.respond_to?(objlabel)
        else
          @k8sobject&.metadata&.labels.respond_to?(objlabel) && @k8sobject.metadata.labels[objlabel] == value
        end
      end

      def has_annotation?(objkey = nil, value = nil)
        # values sometimes are very long descriptions in such cases user might want to only search with key.
        if value.nil?
          @k8sobject&.metadata&.annotations.respond_to?(objkey)
        else
          @k8sobject&.metadata&.annotations.respond_to?(objkey) && @k8sobject.metadata.annotations[objkey] == value
        end
      end

      def exists?
        !@k8sobject.nil?
      end

      def labels
        k8sobject.metadata.labels.to_h
      end

      def annotations
        @k8sobject.metadata.annotations.to_h
      end

      def resource_id
        uid || ''
      end

      def to_s
        @display_name.to_s
      end

      def include?(key)
        @k8sobject.key?(key)
      end

      def running?
        @k8sobject.status.phase == 'Running' unless @k8sobject.status.phase.nil?
      end

      alias resource k8sobject # TODO: remove later
    end
  end
end
