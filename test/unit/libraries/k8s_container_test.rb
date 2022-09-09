# frozen_string_literal: true

require_relative 'resource_test'
require_relative '../../../libraries/k8s_container'

class K8sContainerTest < ResourceTest
  STUB_DATA = {
    'v1': {
      default: {
        pods: [
          {
            name: 'pod1',
            kind: 'pod',
            status: {
              phase: 'running'
            },
            metadata: {
              uid: 'abcd1234',
              name: 'pod1',
              namespace: 'default',
              resourceVersion: 1234,
              annotations: {},
              labels: {}
            },
            spec: {
              containers: [{
                name: 'coredns',
                image: 'k8s.gcr.io/coredns/coredns:v1.8.4',
                command: ['printenv'],
                args: %w[HOSTNAME KUBERNETES_PORT],
                ports:
                  [{ name: 'dns', containerPort: 53, protocol: 'UDP' },
                   { name: 'dns-tcp', containerPort: 53, protocol: 'TCP' },
                   { name: 'metrics', containerPort: 9153, protocol: 'TCP' }],
                resources: { limits: { memory: '170Mi' }, requests: { cpu: '100m', memory: '70Mi' } },
                volumeMounts:
                  [{ name: 'config-volume', readOnly: true, mountPath: '/etc/coredns' },
                   { name: 'kube-api-access-lzl5n',
                     readOnly: true,
                     mountPath: '/var/run/secrets/kubernetes.io/serviceaccount' }],
                livenessProbe:
                  { httpGet: { path: '/health', port: 8080, scheme: 'HTTP' },
                    initialDelaySeconds: 60,
                    timeoutSeconds: 5,
                    periodSeconds: 10,
                    successThreshold: 1,
                    failureThreshold: 5 },
                readinessProbe:
                  { httpGet: { path: '/ready', port: 8181, scheme: 'HTTP' },
                    timeoutSeconds: 1,
                    periodSeconds: 10,
                    successThreshold: 1,
                    failureThreshold: 3 },
                terminationMessagePath: '/dev/termination-log',
                terminationMessagePolicy: 'File',
                imagePullPolicy: 'IfNotPresent',
                securityContext:
                  { capabilities: { add: ['NET_BIND_SERVICE'], drop: ['all'] },
                    readOnlyRootFilesystem: true,
                    allowPrivilegeEscalation: false }
              }]
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'pods'
  NAME = 'pod1'

  def test_name
    assert_equal('coredns', k8s_object.name)
  end

  def test_image
    assert_equal('k8s.gcr.io/coredns/coredns:v1.8.4', k8s_object.image)
  end

  def test_command
    assert_equal(nil, k8s_object.command)
  end

  def test_args
    assert_equal(%w[-conf /etc/coredns/Corefile], k8s_object.args)
  end

  def test_resources
    assert_equal('100m', k8s_object.resources.requests.cpu)
  end

  def test_volumeMounts
    assert(k8s_object.has_volume_mounts?('config-volume'))
  end

  def test_livenessProbe
    assert_equal(5, k8s_object.livenessProbe.timeoutSeconds)
  end

  def test_readinessProbe
    assert_equal(3, k8s_object.readinessProbe.failureThreshold)
  end

  def test_imagePullPolicy
    assert_equal('IfNotPresent', k8s_object.imagePullPolicy)
  end

  def test_securityContext
    assert_equal(['NET_BIND_SERVICE'], k8s_object.securityContext.capabilities.add)
  end

  def test_args
    assert(k8s_object.has_args?('HOSTNAME'))
  end

  def test_command
    assert(k8s_object.has_command?('printenv'))
  end

  private

  def k8s_object
    @k8s_object ||= Inspec::Resources::K8sContainer.new(
      pod_name: 'pod1',
      name: 'coredns',
      backend: Mock::K8s::Transport.new(stub_data: STUB_DATA)
    )
  end
end
