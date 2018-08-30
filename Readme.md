ansible/log-management
=========
[![build status][img-build-status]][link-build-status]

Role installing **Elastic.co** products.

This role will install multiple components of ELK stack and other minor services. See HowTo below and also [defaults](defaults/main.yml) for examples.

## Quickstart
1. Clone repo to your `roles` directory
```
git clone git@github.com:VeselaHouba/log-management.git
```
1. Include role for your servers in `playbook.yml`

```
---
- hosts: all
  roles:
    - log-management
```


Role Variables
--------------


### Host sw roles
Defines what SW from Elastic.co will be installed on server
```
lm_server_roles:
  - elasticsearch
  - kibana
  - auditbeat
  - logstash
  - filebeat
  - rsyslog
  - elastalert
  - cerebro
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
* `lm_elk_version` - Exact version to install. Will install latest available if not defined. Useful when upgrading to newer versions.

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
* `lm_curator_keep_days` - How many days to keep indexes (default: `45`)
* `lm_number_of_replicas`: - How many replicas of shards to keep. (default: `1`)
* `lm_number_of_replicas_age`: - Apply `lm_number_of_replicas` only on replicas older than X days (default: `5`)
* `lm_elasticsearch_jvm_opts:`
  - `{ name: Xms, value: Xms1g }`
  - `{ name: Xmx, value: Xmx1g }`

### kibana related config
* `lm_kibana_port` - Where will kibana listen. (default: `5601`)
* `lm_kibana_host` - Which host will kibana listen on (default: `localhost`)
* `lm_kibana_hostname` - What hostname will kibana expect (default: `{{ ansible_fqdn }}`
* `lm_kibana_es_host` - Elastic backend host (default: `{{ lm_elastic_hosts[0] }}`)
* `lm_kibana_es_port` - Elastic backend port (default: `{{ lm_es_http_port }}`)

### Elastalert related config
* `lm_elastalert_*` - See `defaults/main.yml` for full list.

### Cerebro related config
* `lm_cerebro_url` - URL to download archive for installation
* `lm_cerebro_checksum` - Checksum of archive (avoids re-downloading). Must be changed when URL changes.

### Logstash config
* `lm_logstash_syslog_port` - Port for receiving rsyslog messages (`5044`)
* `lm_logstash_beats_port` - Port for receiving filebeat output (`5088`)

### RSyslog config
* Include server role `rsyslog` in order to configure local rsyslog instance for forwarding messages to logstash backend
* `lm_rsyslog_listen_enable` - Configure rsyslog to listen on defined ports. (default: `false`). Rsyslog will then log incoming messages locally and also forward to logstash. (Useful for direct *app -> syslog* logging instead of *app -> stdout -> docker -> syslog*)
* `lm_rsyslog_listen_port` - Port for listening rsyslog. Used for both, TCP and UDP. (default: `514`)


### Hosts definitions
Must be resovlable (IP or Host). Will be filled into config files
* `lm_elastic_hosts` - `[localhost]`
* `lm_logstash_hosts` - `[localhost]`
* `lm_kibana_hosts` - `[localhost]`




[img-build-status]: http://gitlab.betsys.com/ansible/log-management/badges/master/build.svg
[link-build-status]: http://gitlab.betsys.com/ansible/log-management/builds
