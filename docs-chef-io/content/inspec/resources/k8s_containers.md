+++
title = "k8s_containers resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_containers"
identifier = "inspec/resources/k8s/K8s Containers"
parent = "inspec/resources/k8s"
+++

Use the `k8s_containers` Chef InSpec audit resource to test the configurations of all Containers in a namespace.

## Installation

## Syntax

```ruby
describe k8s_containers do
  #...
end
```

## Parameter

`namespace`
: Namespace of the resource.

## Properties

`uid`
: UID of the Container.

`name`
: Name of the Container.

`namespace`
: Namespace of the Container.

`resource_version`
: Resource version of the Container.

`kind`
: Resource type of the Container.

`metadata`
: Metadata for the Container.

## Examples

### Containers for default namespace must exist

```ruby
 describe k8s_containers do
  it { should exist }
end
```

### Containers for specified namespace must exist

```ruby
describe k8s_containers(namespace: 'kube-system') do
  it { should exist }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}
