+++
title = "k8s_config_maps resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_config_maps"
identifier = "inspec/resources/k8s/K8s Config Map"
parent = "inspec/resources/k8s"
+++


Use the `k8s_config_maps` Chef InSpec audit resource to test the configuration of all Config Maps in a namespace

## Installation

## Syntax

```ruby
describe k8s_config_maps do
  #...
end
```

## Parameters

`type`
: type of the K8s resource that is for query

`namespace`
: namespace of the resource

## Properties

`uid`
: UID of the resource

`name`
: Name of the resource

`namespace`
: Namespace of the resource

`resource_version`
: resource version of the resource

`kind`
: resource type

`metadata`
: metadata for the resource

## Examples

**The config maps for default namespaces should exist**

```ruby
 describe k8s_config_maps do
  it { should exist }
end
```

**The config maps should for given namespace exist**

```ruby
describe k8s_config_maps(namespace: 'kube-system') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
