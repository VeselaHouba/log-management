ansible/log-management
=========
[![build status][img-build-status]][link-build-status]

Role installing **Elastic.co** products.

* TODO: Description

Role Variables
--------------


### Host sw roles
Defines what SW from Elastic.co will be installed on server
```
lm_server_roles:
  - kibana
  - elasticsearch
  - auditbeat
  - logstash
  # - filebeat - Not avaliable yet
  # - docker_rsyslog - Not avaliable yet
  ```
default:
```
lm_server_roles: []
```


### Shared config of elastic products
* `lm_es_major_version` - Major version of Elastic products (default: `6`)
* `lm_es_repo_url` - URL for elastic repo
* `lm_es_repo_gpg_key` - URL to elastic GPG key
* `lm_es_java_version` - What java version should be installed (default `1.8.0-openjdk`)

### Elasticsearch related config
* `lm_es_cluster_name` - Name of cluster (default: `log`)
* `lm_es_node_name` - Name of node in cluster (default: `{{ ansible_fqdn }}`)
* `lm_es_network_host` - Address to listen on (default: `0.0.0.0`)
* `lm_es_http_port` - Elastic port for receiving requests (default: `9200`)
* `lm_es_min_cluster_nodes` - Minimal number of nodes which the
 cluster needs (n+1)/2. (default: `1`)
* `lm_es_logdir` - default: /var/log/elasticsearch
* `lm_es_datadir` - default: /var/lib/elasticsearch
* `lm_use_curator` - Enable automatic drop of indexes (cleaning) default: `true`
* `lm_curator_keep_days` - How many days to keep indexes default: `45`

### kibana related config
* `lm_kibana_port` - Where will kibana listen. (default: `5601`)
* `lm_kibana_host` - Which host will kibana listen on (default: `localhost`)
* `lm_kibana_hostname` - What hostname will kibana expect (default: `{{ ansible_fqdn }}`
* `lm_kibana_es_host` - Elastic backend host (default: `{{ lm_elastic_hosts[0] }}`)
* `lm_kibana_es_port` - Elastic backend port (default: `{{ lm_es_http_port }}`)

### Hosts definitions
Must be resovlable (IP or Host). Will be filled into config files
* `lm_elastic_hosts` - `[localhost]`
* `lm_logstash_hosts` - `[localhost]`
* `lm_kibana_hosts` - `[localhost]`




[img-build-status]: http://gitlab.betsys.com/ansible/log-management/badges/master/build.svg
[link-build-status]: http://gitlab.betsys.com/ansible/log-management/builds
