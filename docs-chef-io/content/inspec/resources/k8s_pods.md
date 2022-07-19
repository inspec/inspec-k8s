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

Use the `k8s_pods` Chef InSpec audit resource to test the configuration of all Pods in a namespace.

## Installation

## Syntax

```ruby
describe k8s_pods do
  #...
end
```

## Parameters

`type`
: Type of the K8s resource that is for a query.

`namespace`
: Namespace of the resource.

## Properties

`uid`
: UID of the Pod.

`name`
: Name of the Pod.

`namespace`
: Namespace of the Pod.

`resource_version`
: Resource version of the Pod.

`kind`
: Resource type of the Pod.

`metadata`
: Metadata for the Pod.

## Examples

### Pods for default namespaces must exist

```ruby
 describe k8s_pods do
  it { should exist }
end
```

### Pods for specified namespaces must exist

```ruby
describe k8s_pods(namespace: 'kube-system') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
