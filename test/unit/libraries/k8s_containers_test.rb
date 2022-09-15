# frozen_string_literal: true

require_relative 'resource_test'
require_relative '../../../libraries/k8s_containers'

class K8sContainersTest < ResourceTest
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
              containers: {
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
              }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'pods'

  def test_names
    assert_includes(k8s_objects.names, 'coredns')
  end

  def test_images
    assert_includes(k8s_objects.images, 'k8s.gcr.io/coredns/coredns:v1.8.4')
  end

  def test_commands
    assert_includes(k8s_objects.commands,'printenv')
  end

  def test_args
    assert_includes(k8s_objects.args, 'HOSTNAME')
  end

  def test_resources
    assert_includes(k8s_objects.resources.map(&:limits).map(&:memory), '170Mi')
  end

  def test_volumeMounts
    assert_includes(k8s_objects.volumeMounts.map(&:name), 'config-volume')
  end

  def test_livenessProbes
    assert_includes(k8s_objects.livenessProbes.map(&:initialDelaySeconds), 60)
  end

  def test_readinessProbes
    assert_includes(k8s_objects.readinessProbes.map(&:failureThreshold), 3)
  end

  def test_imagePullPolicies
    assert_includes(k8s_objects.imagePullPolicies, 'IfNotPresent')
  end

  def test_securityContexts
    assert_includes(k8s_objects.securityContexts.map(&:capabilities).map(&:add).flatten, 'NET_BIND_SERVICE')
  end

  private

  def k8s_objects
    @k8s_objects ||= Inspec::Resources::K8sContainers.new(
      backend: Mock::K8s::Transport.new(stub_data: STUB_DATA),
      type: TYPE,
      namespace: NAMESPACE
    )
  end
end
