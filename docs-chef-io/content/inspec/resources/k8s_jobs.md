+++
title = "k8s_jobs resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_jobs"
identifier = "inspec/resources/k8s/K8s Jobs"
parent = "inspec/resources/k8s"
+++

Use the `k8s_jobs` Chef InSpec audit resource to test the configurations of all jobs in a namespace.

## Installation

## Syntax

```ruby
describe k8s_jobs do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default is **default**).

## Properties

`uids`
: UID of the jobs.

`names`
: Name of the jobs.

`namespaces`
: Namespace of the jobs.

`resource_versions`
: Resource version of the jobs.

`labels`
: Labels associated with the jobs.

`annotations`
: Annotations associated with the jobs.

`kinds`
: Resource type of the jobs.

## Examples

### Jobs for default namespace must exist and test its properties

```ruby
describe k8s_jobs do
  it { should exist }
  its('names') { should include 'HELLO' }
  its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
  its('namespaces') { should include 'DEFAULT' }
  its('resource_versions') { should include '70517' }
  its('kinds') { should include 'JOB' }
  its('labels') { should_not be_empty }
  its('annotations') { should_not be_empty }
end
```

### Jobs for specified namespace must exist

```ruby
describe k8s_jobs(namespace: 'NAMESPACE') do
  it { should exist }
  its('names') { should include 'HELLO-WORLD' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
