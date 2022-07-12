+++
title = "k8s_pods resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_pods"
identifier = "inspec/resources/k8s/K8s Pods"
parent = "inspec/resources/k8s"
+++


Use the `k8s_pods` Chef InSpec audit resource to test the configuration of all Pods in a namespace

## Installation

## Syntax

```ruby
describe k8s_pods do
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

**The pods for default namespaces should exist**

```ruby
 describe k8s_pods do
  it { should exist }
end
```

**The pods should for given namespace exist**

```ruby
describe k8s_pods(namespace: 'kube-system') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}