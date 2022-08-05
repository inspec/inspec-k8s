+++
title = "k8s_job resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_job"
identifier = "inspec/resources/k8s/K8s Job"
parent = "inspec/resources/k8s"
+++


Use the `k8s_job` Chef InSpec audit resource to test the configuration of a specific job in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_job(name: 'HELLO') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the job.

`namespace`
: Namespace of the resource (default: **default**).

## Properties

`uid`
: UID of the job.

`name`
: Name of the job.

`namespace`
: Namespace of the job.

`resource_version`
: Resource version of the job. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the job.

`annotations`
: Annotations associated with the job.

`kind`
: Resource type of the job.

`creation_timestamp`
: Creation time of the job. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the job.

## Examples

### Job for default namespace must exist and test its properties

```ruby
describe k8s_job(name: 'pi') do
  it { should exist }
  its('uid') { should eq 'a31e4d72-816d-4678-8cda-34973bc7808b' }
  its('resource_version') { should eq '818' }
  its('labels') { should_not be_empty }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'pi' }
  its('namespace') { should eq 'DEFAULT' }
  its('kind') { should eq 'JOB' }
  its('creation_timestamp') { should eq '2022-08-02T12:05:40Z' }
end
```

### Job for a specified namespace must exist

```ruby
describe k8s_job(name: 'HELLO-WORLD', namespace: 'NAMESPACE') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
