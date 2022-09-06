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
                name: "coredns",
                image: "k8s.gcr.io/coredns/coredns:v1.8.4",
                args: ["-conf", "/etc/coredns/Corefile"],
                ports:
                  [{:name=>"dns", :containerPort=>53, :protocol=>"UDP"},
                   {:name=>"dns-tcp", :containerPort=>53, :protocol=>"TCP"},
                   {:name=>"metrics", :containerPort=>9153, :protocol=>"TCP"}],
                resources: {:limits=>{:memory=>"170Mi"}, :requests=>{:cpu=>"100m", :memory=>"70Mi"}},
                volumeMounts:
                  [{:name=>"config-volume", :readOnly=>true, :mountPath=>"/etc/coredns"},
                   {:name=>"kube-api-access-lzl5n",
                    :readOnly=>true,
                    :mountPath=>"/var/run/secrets/kubernetes.io/serviceaccount"}],
                livenessProbe:
                  {:httpGet=>{:path=>"/health", :port=>8080, :scheme=>"HTTP"},
                   :initialDelaySeconds=>60,
                   :timeoutSeconds=>5,
                   :periodSeconds=>10,
                   :successThreshold=>1,
                   :failureThreshold=>5},
                readinessProbe:
                  {:httpGet=>{:path=>"/ready", :port=>8181, :scheme=>"HTTP"},
                   :timeoutSeconds=>1,
                   :periodSeconds=>10,
                   :successThreshold=>1,
                   :failureThreshold=>3},
                terminationMessagePath: "/dev/termination-log",
                terminationMessagePolicy: "File",
                imagePullPolicy: "IfNotPresent",
                securityContext:
                  {:capabilities=>{:add=>["NET_BIND_SERVICE"], :drop=>["all"]},
                   :readOnlyRootFilesystem=>true,
                   :allowPrivilegeEscalation=>false}
              }
            }
          }
        ]
      }
    }
  }.freeze

  TYPE = 'pods'


  def test_names
    assert_includes(k8s_objects.names, 'pod1')
  end

  def test_images
    assert_equal('default', k8s_objects.images)
  end

  def test_commands
    assert_equal('pod', k8s_objects.commands)
  end

  def test_args
    assert_equal(1234, k8s_objects.args)
  end

  def test_resources
    assert_equal(k8s_objects.resources, [])
  end

  def test_volumeMounts
    assert_equal(k8s_objects.volumeMounts, [])
  end

  def test_livenessProbes
    assert_equal(k8s_objects.livenessProbes, [])
  end

  def test_readinessProbes
    assert_equal(k8s_objects.readinessProbes, [])
  end

  def test_imagePullPolicies
    assert_equal(k8s_objects.imagePullPolicies, [])
  end

  def test_securityContexts
    assert_equal(k8s_objects.securityContexts, [])
  end

  private

  def k8s_objects
    @k8s_objects ||= Inspec::Resources::K8sContainers.new(
      backend: Mock::K8s::Transport.new(stub_data: STUB_DATA)
    )
  end
end

