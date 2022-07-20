+++
title = "k8s_nodes resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_nodes"
identifier = "inspec/resources/k8s/K8s Nodes"
parent = "inspec/resources/k8s"
+++

Use the `k8s_nodes` Chef InSpec audit resource to test the configuration of all Nodes.

## Installation

## Syntax

```ruby
describe k8s_nodes do
  #...
end
```

## Properties

`uids`
: UID of the Nodes.

`names`
: Name of the Nodes.

`resource_versions`
: Resource version of the Nodes.

`kinds`
: Resource type of the Nodes.

## Examples

### Verify nodes includes a node with a specified name and UID.

```ruby
 describe k8s_nodes do
  it { should exist }
  its('names') { should include 'node-name' }
  its('uids') { should include 'uid-of-the-node' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
