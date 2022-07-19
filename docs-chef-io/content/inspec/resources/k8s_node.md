+++
title = "k8s_node resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "k8s_node"
    identifier = "inspec/resources/k8s/K8s Node"
    parent = "inspec/resources/k8s"
+++


Use the `k8s_node` Chef InSpec audit resource to test the configuration of k8s node.

## Installation

## Syntax

```ruby
describe k8s_node(name: "NAME") do
  #...
end
```

## Parameters

`name`
: name of the Node

## Properties

`uid`
: UID of the Node.

`kind`
: type of k8s resource.

`resource_version`
: resource version of the Node.

`labels`
: labels attached to Node.

`annotations`
: metadata about the Node attached in the form of annotations.

## Examples

### The node with specified name shoule exist

```ruby
describe k8s_node(name: "My-Node") do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}

### have_label

The `have_label` matcher verifies if the specified key and value are present in the Node lables.

```ruby
describe k8s_node(name: "My-Node") do
  it { should have_label('foo', 'bar') }
end
```

### have_annotation

The `have_annotation` matcher verifies if the specified key and value are present in the Node annotations.

```ruby
describe k8s_node(name: "My-Node") do
  it { should have_annotation('foo', 'bar') }
end
```
