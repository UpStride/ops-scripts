## backup docker registry
- user story :<br/>
*I want to browse an organization github and extract general information on public repos (repos, number of stars, language).*
- requirements : 
	- python3
	- bash

**set the auth token**
Export github token in the environment
```bash
export GITHUB_USERNAME=your_username
export GITHUB_TOKEN=your_private_token

```

**run the script**
```bash
bash browse-github/run -o your_organization_name
```

**example(s) output**
In the example below, the organization is missing or have private repos only. Github server returns a clear explanation (404). The script catches the explanation and exits cleanly.
````bash
$ bash browse-github/run -o meta
+ dependencies checks
+ list github repos
ERROR: 
        Github server returned explicit error code:: 404
        Stopping the lookup..
INFO: no repos found
````
In the example below, the organization is there and do have public repos. The script returns all repos ranked by popularity and give general information (main language and url).
The table gives an overview of an organization activity and popularity on Github.
````bash
$ bash browse-github/run -o kubernetes
+ dependencies checks
+ list github repos
INFO: public repos total = 78
INFO: 
+------------------------------+-------+------------------+------------------------------------------------------------+
|             Name             | Stars |     Language     |                            url                             |
+------------------------------+-------+------------------+------------------------------------------------------------+
|          kubernetes          | 98833 |        Go        |          https://github.com/kubernetes/kubernetes          |
|           minikube           | 26578 |        Go        |           https://github.com/kubernetes/minikube           |
|        ingress-nginx         | 15017 |        Go        |        https://github.com/kubernetes/ingress-nginx         |
|             kops             | 14992 |        Go        |             https://github.com/kubernetes/kops             |
|          dashboard           | 12628 |        Go        |          https://github.com/kubernetes/dashboard           |
|          community           | 11022 | Jupyter Notebook |          https://github.com/kubernetes/community           |
|           kompose            |  8556 |        Go        |           https://github.com/kubernetes/kompose            |
|          client-go           |  7708 |        Go        |          https://github.com/kubernetes/client-go           |
|          autoscaler          |  6867 |        Go        |          https://github.com/kubernetes/autoscaler          |
|           examples           |  5591 |      Shell       |           https://github.com/kubernetes/examples           |
|      kube-state-metrics      |  4566 |        Go        |      https://github.com/kubernetes/kube-state-metrics      |
|           website            |  3827 |       HTML       |           https://github.com/kubernetes/website            |
|          test-infra          |  3637 |        Go        |          https://github.com/kubernetes/test-infra          |
|           kubeadm            |  3451 |        Go        |           https://github.com/kubernetes/kubeadm            |
|         enhancements         |  2894 |        Go        |         https://github.com/kubernetes/enhancements         |
|      sample-controller       |  2712 |        Go        |      https://github.com/kubernetes/sample-controller       |
|    node-problem-detector     |  2365 |        Go        |    https://github.com/kubernetes/node-problem-detector     |
|           kubectl            |  2333 |        Go        |           https://github.com/kubernetes/kubectl            |
|           git-sync           |  1789 |      Shell       |           https://github.com/kubernetes/git-sync           |
|        code-generator        |  1442 |        Go        |        https://github.com/kubernetes/code-generator        |
|         ingress-gce          |  1215 |        Go        |         https://github.com/kubernetes/ingress-gce          |
|             dns              |  820  |        Go        |             https://github.com/kubernetes/dns              |
|          perf-tests          |  784  |        Go        |          https://github.com/kubernetes/perf-tests          |
|         apimachinery         |  687  |        Go        |         https://github.com/kubernetes/apimachinery         |
|             api              |  554  |        Go        |             https://github.com/kubernetes/api              |
|          apiserver           |  521  |        Go        |          https://github.com/kubernetes/apiserver           |
|   cloud-provider-openstack   |  520  |        Go        |   https://github.com/kubernetes/cloud-provider-openstack   |
|            gengo             |  496  |        Go        |            https://github.com/kubernetes/gengo             |
|            k8s.io            |  477  |       HCL        |            https://github.com/kubernetes/k8s.io            |
|         sig-release          |  462  |      Shell       |         https://github.com/kubernetes/sig-release          |
|             klog             |  461  |        Go        |             https://github.com/kubernetes/klog             |
|       sample-apiserver       |  450  |        Go        |       https://github.com/kubernetes/sample-apiserver       |
|           metrics            |  447  |        Go        |           https://github.com/kubernetes/metrics            |
|           release            |  446  |        Go        |           https://github.com/kubernetes/release            |
|   design-proposals-archive   |  347  |     Makefile     |   https://github.com/kubernetes/design-proposals-archive   |
| cloud-provider-alibaba-cloud |  327  |        Go        | https://github.com/kubernetes/cloud-provider-alibaba-cloud |
|      cloud-provider-aws      |  315  |        Go        |      https://github.com/kubernetes/cloud-provider-aws      |
|           cri-api            |  310  |        Go        |           https://github.com/kubernetes/cri-api            |
|            utils             |  271  |        Go        |            https://github.com/kubernetes/utils             |
|      sample-cli-plugin       |  259  |        Go        |      https://github.com/kubernetes/sample-cli-plugin       |
|       registry.k8s.io        |  249  |        Go        |       https://github.com/kubernetes/registry.k8s.io        |
|         cli-runtime          |  247  |        Go        |         https://github.com/kubernetes/cli-runtime          |
|         kube-openapi         |  243  |        Go        |         https://github.com/kubernetes/kube-openapi         |
|       kube-aggregator        |  227  |        Go        |       https://github.com/kubernetes/kube-aggregator        |
|           kubelet            |  225  |        Go        |           https://github.com/kubernetes/kubelet            |
|             org              |  214  |        Go        |             https://github.com/kubernetes/org              |
|   apiextensions-apiserver    |  207  |        Go        |   https://github.com/kubernetes/apiextensions-apiserver    |
|    cloud-provider-vsphere    |  198  |        Go        |    https://github.com/kubernetes/cloud-provider-vsphere    |
|        cloud-provider        |  186  |        Go        |        https://github.com/kubernetes/cloud-provider        |
| committee-security-response  |  155  |       None       | https://github.com/kubernetes/committee-security-response  |
| kubernetes-template-project  |  153  |       None       | https://github.com/kubernetes/kubernetes-template-project  |
|          kube-proxy          |  142  |        Go        |          https://github.com/kubernetes/kube-proxy          |
|        kube-scheduler        |  127  |        Go        |        https://github.com/kubernetes/kube-scheduler        |
|         sig-security         |  119  |      Python      |         https://github.com/kubernetes/sig-security         |
|          repo-infra          |   91  |     Starlark     |          https://github.com/kubernetes/repo-infra          |
|        component-base        |   87  |        Go        |        https://github.com/kubernetes/component-base        |
|      cloud-provider-gcp      |   82  |        Go        |      https://github.com/kubernetes/cloud-provider-gcp      |
|    pod-security-admission    |   77  |        Go        |    https://github.com/kubernetes/pod-security-admission    |
|           steering           |   72  |       None       |           https://github.com/kubernetes/steering           |
|        publishing-bot        |   70  |        Go        |        https://github.com/kubernetes/publishing-bot        |
|   kube-controller-manager    |   69  |        Go        |   https://github.com/kubernetes/kube-controller-manager    |
|       contributor-site       |   50  |       HTML       |       https://github.com/kubernetes/contributor-site       |
|    legacy-cloud-providers    |   46  |        Go        |    https://github.com/kubernetes/legacy-cloud-providers    |
|      controller-manager      |   44  |        Go        |      https://github.com/kubernetes/controller-manager      |
|         mount-utils          |   43  |        Go        |         https://github.com/kubernetes/mount-utils          |
|      cluster-bootstrap       |   29  |        Go        |      https://github.com/kubernetes/cluster-bootstrap       |
|      system-validators       |   29  |        Go        |      https://github.com/kubernetes/system-validators       |
|    cloud-provider-sample     |   16  |       None       |    https://github.com/kubernetes/cloud-provider-sample     |
|           node-api           |   14  |        Go        |           https://github.com/kubernetes/node-api           |
|           funding            |   13  |       None       |           https://github.com/kubernetes/funding            |
|      component-helpers       |   12  |        Go        |      https://github.com/kubernetes/component-helpers       |
|     csi-translation-lib      |   10  |        Go        |     https://github.com/kubernetes/csi-translation-lib      |
|             kms              |   9   |        Go        |             https://github.com/kubernetes/kms              |
|    cel-admission-webhook     |   9   |        Go        |    https://github.com/kubernetes/cel-admission-webhook     |
|   noderesourcetopology-api   |   8   |      Shell       |   https://github.com/kubernetes/noderesourcetopology-api   |
|         sig-testing          |   5   |       None       |         https://github.com/kubernetes/sig-testing          |
| dynamic-resource-allocation  |   5   |        Go        | https://github.com/kubernetes/dynamic-resource-allocation  |
|           .github            |   1   |       None       |           https://github.com/kubernetes/.github            |
+------------------------------+-------+------------------+------------------------------------------------------------+

````

**Known Issues of Script**
- Rate limit: we observe after dozens of executions Github returns a 403 to the script requests. We suspect it to be a rate limitation or a bot security that degrades the performance of the script.



