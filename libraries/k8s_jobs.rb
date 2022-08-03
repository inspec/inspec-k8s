# frozen_string_literal: true

require 'k8sobjects'

module Inspec
  module Resources
    # k8s_jobs resource to get data about all kubernetes jobs.
    class K8sJobs < K8sObjects
      name 'k8s_jobs'
      desc 'Verifies settings for all jobs'

      example "
      describe k8s_jobs do
        it { should exist }
        its('names') { should include 'pi' }
        its('names') { should include 'pi-2' }
        its('uids') { should include 'a31e4d72-816d-4678-8cda-34973bc7808b' }
      end

      describe k8s_jobs(namespace: 'my-namespace') do
        it { should exist }
        its('names') { should include 'hello-world' }
      end
    "

      def initialize(opts = {})
        opts[:type] = 'jobs'
        opts[:api] = 'batch/v1'
        super(opts)
      end
    end
  end
end
