+++
title = "k8s_cronjobs resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
[menu.inspec]
title = "k8s_cronjobs"
identifier = "inspec/resources/k8s/K8s Cronjobs"
parent = "inspec/resources/k8s"
+++

Use the `k8s_cronjobs` Chef InSpec audit resource to test the configurations of all Cronjobs in a namespace.

## Installation

## Syntax

```ruby
describe k8s_cronjobs do
  it { should exist }
end
```

## Parameter

`namespace`
: Namespace of the resource (default is **default**).

## Properties

`uids`
: UID of the Cronjobs.

`names`
: Name of the Cronjobs.

`namespaces`
: Namespace of the Cronjobs.

`resource_versions`
: Resource version of the Cronjobs.

`labels`
: Labels associated with the Cronjobs.

`annotations`
: Annotations associated with the Cronjobs.

`kinds`
: Resource type of the Cronjobs.

## Examples

### Cronjobs for default namespace must exist and test its properties

```ruby
describe k8s_cronjobs do
  it { should exist }
  its('names') { should include 'hello' }
  its('uids') { should include '378c1a39-cddc-4df6-bf5a-593779eb26fc' }
  its('namespaces') { should include 'default' }
  its('resource_versions') { should include '70517' }
  its('kinds') { should include 'CronJob' }
  its('labels') { should be_empty }
  its('annotations') { should_not be_empty }
end
```

### Cronjobs for specified namespace must exist

```ruby
describe k8s_cronjobs(namespace: 'my-namespace') do
  it { should exist }
  its('names') { should include 'hello-world' }
end
```

## Matchers

{{% inspec/inspec_matchers_link %}}