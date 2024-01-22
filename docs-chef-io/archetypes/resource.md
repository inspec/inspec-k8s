+++
title = "{{ .Name }} resource"
draft = false
gh_repo = "inspec"
platform = "k8s"

[menu]
  [menu.inspec]
    title = "{{ .Name | humanize | title }}"
    identifier = "inspec/resources/k8s/{{ .Name | humanize | title }}"
    parent = "inspec/resources/k8s"
+++
{{/* Run `hugo new -k resource inspec/resources/RESOURCE_NAME.md` to generate a new resource page. */}}

Use the `{{ .Name }}` Chef InSpec audit resource to test the configuration of...

## Install

## Syntax

```ruby
describe {{ .Name }} do
  #...
end
```

## Parameters

`PARAMETER`
: PARAMETER DESCRIPTION

`PARAMETER`
: PARAMETER DESCRIPTION

## Properties

`PROPERTY`
: PROPERTY DESCRIPTION

`PROPERTY`
: PROPERTY DESCRIPTION

## Examples

**EXAMPLE DESCRIPTION**

```ruby
describe {{ .Name }} do
  #...
end
```

**EXAMPLE DESCRIPTION**

```ruby
describe {{ .Name }} do
  #...
end
```

## Matchers

{{< readfile file="content/inspec/reusable/md/inspec_matchers_link.md" >}}
