+++
title = "k8s_network_policy resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_network_policy"
identifier = "inspec/resources/k8s/K8s Network Policy"
parent = "inspec/resources/k8s"
+++


Use the `k8s_network_policy` Chef InSpec audit resource to test the configuration of a specific Network Policy in the specified namespace.

## Installation

## Syntax

```ruby
describe k8s_network_policy(name: 'coredns', namespace: 'kube-system') do
  it { should exist }
end
```

## Parameter

`name`
: Name of the Network Policy.

`namespace`
: Namespace of the resource (default is **default**).

## Properties

`uid`
: UID of the Network Policy.

`name`
: Name of the Network Policy.

`namespace`
: Namespace of the Network Policy.

`resource_version`
: Resource version of the Network Policy. This is an alias of `resourceVersion`.

`labels`
: Labels associated with the Network Policy.

`annotations`
: Annotations associated with the Network Policy.

`kind`
: Resource type of the Network Policy.

`creation_timestamp`
: Creation time of the Network Policy. This is an alias of `creationTimestamp`.

`metadata`
: Metadata for the Network Policy.

## Examples

### Network Policy for default namespace must exist and test its properties

```ruby
describe k8s_network_policy(name: "test-network-policy") do
  it { should exist }
  its('uid') { should eq '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
  its('resource_version') { should eq '129558' }
  its('labels') { should be_empty }
  its('annotations') { should_not be_empty }
  its('name') { should eq 'test-network-policy' }
  its('namespace') { should eq 'default' }
  its('kind') { should eq 'NetworkPolicy' }
  its('creation_timestamp') { should eq '2022-08-02T09:47:56Z' }
  its('metadata') { should_not be_nil }
end
```

### Network Policy for a specified namespace must exist

```ruby
describe k8s_network_policy(namespace: 'my-namespace', name: 'my-network-policy') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
