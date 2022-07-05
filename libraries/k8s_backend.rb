# frozen_string_literal: true

# K8s Inspec Backend Classes
#
# Based on the GCP Inspec classes
#

require 'json'

# Base class for K8s resources - depends on train K8s transport for connection
class K8sResourceBase < Inspec.resource(1)
  attr_reader :opts, :k8s, :item, :count

  def initialize(opts)
    @opts = opts
    @k8s = inspec.backend
    @count = item.length if item.respond_to? :length
  end

  def failed_resource?
    @failed_resource
  end

  # Intercept K8s client exceptions
  def catch_k8s_errors
    yield
    # create custom messages as needed
  rescue K8s::Error::Conflict => e
    error = JSON.parse(e.body)
    fail_resource error['error']['message']
    @failed_resource = true
    nil
  rescue K8s::Error::NotFound => e
    error = JSON.parse(e.body)
    fail_resource error['error']['message']
    @failed_resource = true
    nil
  rescue Excon::Error::Socket => e
    error = JSON.parse(e.body)
    fail_resource error['error']['message']
    @failed_resource = true
    nil
  end
end

module Validators
  # @see https://github.com/inspec/inspec-aws/blob/master/libraries/aws_backend.rb#L209
  #
  # @param opts [Hash] The parameters to be validated.
  # @param resource_name [String] The name of the method/resource that the parameters are validated in.
  # @param allow [Array] The list of optional parameters.
  # @param required [Array] The list of required parameters.
  # @param require_any_of [Array] The list of parameters that at least one of them are required.
  def self.validate_parameters(resource_name: nil, allow: [], required: nil, require_any_of: nil, opts: {}, skip_length: false) # rubocop:disable Metrics/ParameterLists
    raise ArgumentError, "Parameters must be provided as a Hash object. Provided #{opts.class}" unless opts.is_a?(Hash)

    allow += Validators.validate_params_required(resource_name, required, opts) if required
    allow += Validators.validate_params_require_any_of(resource_name, require_any_of, opts) if require_any_of
    Validators.validate_params_allow(allow, opts, skip_length)
    true
  end

  # @return [String] Provided parameter within require only one of parameters.
  # @param require_only_one_of [Array]
  def self.validate_params_only_one_of(resource_name = nil, require_only_one_of, opts)
    # At least one of them has to exist.
    Validators.validate_params_require_any_of(resource_name, require_only_one_of, opts)
    provided = require_only_one_of.select { |i| opts.key?(i) }
    raise ArgumentError, "Either one of #{require_only_one_of} is required. Provided: #{provided}." if provided.size > 1

    # There should be only one parameter at this point.
    provided.first
  end

  # @return [Array] Required parameters
  # @param required [Array]
  def self.validate_params_required(resource_name = nil, required, opts)
    unless opts.is_a?(Hash) && required.all? do |req|
             opts.key?(req) && !opts[req].nil? && opts[req] != ''
           end
      raise ArgumentError,
            "#{resource_name}: `#{required.uniq - opts.keys.uniq}` must be provided"
    end

    required
  end

  # @return [Array] Require any of parameters
  # @param require_any_of [Array]
  def self.validate_params_require_any_of(resource_name = nil, require_any_of, opts)
    unless opts.is_a?(Hash) && require_any_of.any? do |req|
             opts.key?(req) && !opts[req].nil? && opts[req] != ''
           end
      raise ArgumentError,
            "#{resource_name}: One of `#{require_any_of}` must be provided."
    end

    require_any_of
  end

  # @return [Array] Allowed parameters
  # @param allow [Array]
  def self.validate_params_allow(allow, opts, skip_length = false) # rubocop:disable Style/OptionalBooleanParameter TODO: Fix this.
    if !opts[:resource_data] && !skip_length
      raise ArgumentError, 'Arguments or values can not be longer than 500 characters.' if # rubocop:disable Style/SoleNestedConditional TODO: Fix this.
opts.any? do |k, v|
  k.size > 100 || v.to_s.size > 500
end
    end
    raise ArgumentError, 'Scalar arguments not supported.' unless defined?(opts.keys)
    raise ArgumentError, "Unexpected arguments found: #{opts.keys.uniq - allow.uniq}" unless opts.keys.all? do |a|
                                                                                               allow.include?(a)
                                                                                             end
    raise ArgumentError, 'Provided parameter should not be empty.' unless opts.values.all? do |a|
      return true if a.instance_of?(Integer)
      return true if [TrueClass, FalseClass].include?(a.class)

      !a.empty?
    end
  end
end
