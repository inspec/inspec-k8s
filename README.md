# InSpec Kubernetes Resource Pack

This InSpec resource pack provides InSpec helpers to validate the spec of any object/resource inside Kubernetes.

## Usage

At this point, the following Inspec base resources are implemented:

- k8sobjects
- k8sobject

This allows for listing/filtering objects:

```ruby
describe k8sobjects(api: 'v1', type: 'pods', namespace: 'default', labelSelector: 'run=nginx') do
  it { should exist }
  ...
end
```

```ruby
describe k8sobjects(api: 'v1', type: 'namespaces', labelSelector: 'myns=prod') do
  it { should exist }
  ...
end
```

And then for assessing the spec of a specific object:

```ruby
describe k8sobject(api: 'v1', type: 'pod', namespace: 'default', name: 'my-pod') do
  it { should exist }
  its('name') { should eq 'my-pod' }
  ...
end
```

## Preconditions

- Inspec 3.7+ or 4.x+
- InSpec K8s train/backend plugin [train-kubernetes](https://github.com/bgeesaman/train-kubernetes)

## Using with an Inspec Profile

Refer to the [sample inspec-k8s profile](https://github.com/bgeesaman/inspec-k8s-sample)

## Troubleshooting

If you run into issues installing via `inspec plugin install train-kubernetes`, try:

* Try running `gem install train-kubernetes` before `inspec plugin install train-kubernetes`.
* Ensure the `~/.inspec/plugins.json` has `"0.1.3"` and not `"= 0.1.3"` for the `version` value.  Modify it by hand if needed.
* Ensure you can cleanly install the `k8s-client` gem version `0.10.4` or greater.  e.g. `gem install k8s-client -v 0.10.4`
* Ensure that only one version of the `excon` gem is installed.  e.g. `gem list | grep excon`.  If you see two versions, `gem uninstall excon` and remove the older version.

## Maintainers
Currently maintained by Chef Software, Inc. Originally created by [Brad Geesaman](https://github.com/bgeesaman).
