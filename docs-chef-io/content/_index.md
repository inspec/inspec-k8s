+++
title = "About the Chef InSpec Kubernetes resource pack"
draft = false
linkTitle = "Kubernetes resource pack"
summary = "Chef InSpec resources for auditing Kubernetes."

[cascade]
  [cascade.params]
    platform = "k8s"

[menu.k8s]
  title = "About Kubernetes resources"
  identifier = "inspec/resources/k8s/about"
  parent = "inspec/resources/k8s"
  weight = 10
+++

Chef InSpec Kubernetes resources allow you to audit and validate the configuration, security, and compliance of your Kubernetes clusters.

## Requirements

- Inspec 3.7 or greater
- InSpec K8s train/backend plugin [train-kubernetes](https://github.com/inspec/train-kubernetes)

## Usage

To create and run a profile against a Kubernetes cluster, follow these steps:

1. Ensure your `KUBECONFIG` environment variable or `~/.kube/config` file has a valid configuration and credentials for the target cluster.

1. Define the platform and this resource pack as a dependency in your profile's `inspec.yml` file:

    ```yml
    supports:
      platform: k8s
    depends:
      - name: inspec-k8s
        url: https://github.com/inspec/inspec-k8s/archive/main.tar.gz
    ```

1. Define controls using the resources listed below.

1. Execute the profile against your cluster:

    ```sh
    inspec exec profile -t k8s://
    ```

## Example

For an example profile, see the [inspec-k8s-sample example repository](https://github.com/inspec/inspec-k8s-sample).

## Kubernetes resources

{{< inspec_resources_filter >}}

The following Chef InSpec Kubernetes resources are available in this resource pack.

{{< inspec_resources section="k8s" platform="k8s" >}}
