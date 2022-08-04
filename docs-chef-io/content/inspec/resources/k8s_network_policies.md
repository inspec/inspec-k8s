+++
title = "k8s_network_policies resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_network_policies"
identifier = "inspec/resources/k8s/K8s NetworkPolicies"
parent = "inspec/resources/k8s"
+++

Use the `k8s_network_policies` Chef InSpec audit resource to test the configurations of all network policies in a namespace.

## Installation

## Syntax

```ruby
describe k8s_network_policies do
  it { should exist }
  its('names') { should include 'my-network-policy' }
end
```

## Parameter

`namespace`
: Namespace of the resource (default is **default**).

## Properties

`uids`
: UID of the Network Policies.

`names`
: Name of the Network Policies.

`namespaces`
: Namespace of the Network Policies.

`resource_versions`
: Resource version of the Network Policies.

`labels`
: Labels associated with the Network Policies.

`annotations`
: Annotations associated with the Network Policies.

`kinds`
: Resource type of the Network Policies.

## Examples

### NetworkPolicies for default namespace must exist

```ruby
describe k8s_network_policies do
  it { should exist }
  its('names') { should include 'my-network-policy' }
end
```

### NetworkPolicies for specified namespace must exist and test its properties

```ruby
describe k8s_network_policies(namespace: 'my-namespace') do
  it { should exist }
  its('names') { should include 'test-network-policy' }
  its('uids') { should include '0beb1fc6-8af7-4607-b3c0-2bff65d4abd6' }
  its('resource_versions') { should include '129558' }
  its('labels') { should_not be_empty }
  its('annotations') { should_not be_empty }
  its('namespaces') { should include 'my-namespace' }
  its('kinds') { should include 'NetworkPolicy' }
  its('metadata') { should_not be_nil }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
