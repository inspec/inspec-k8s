+++
title = "k8sobject resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8sobject"
identifier = "inspec/resources/k8s/K8s Object"
parent = "inspec/resources/k8s"
+++


Use the `k8sobject` Chef InSpec audit resource to test the configuration of...

## Installation

## Syntax

```ruby
describe k8sobject(type: K8s_RESOURCE_TYPE, namespace: NAMESPACE, name: RESOURCE_NAME) do
  #...
end
```

## Parameters

`type`
: type of the K8s resource that is for query

`namespace`
: namespace of the resource

`name`
: Name of the resource

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

**The kube-system, kube-public, and default namespaces should exist**

```ruby
 describe k8sobject(api: 'v1', type: 'namespaces', name: 'kube-system') do
  it { should exist }
end
```

**The kube-system pods should exist**

```ruby
k8sobject(api: 'v1', type: 'pods', namespace: 'kube-system', labelSelector: 'k8s-app=kube-proxy') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}