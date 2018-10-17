import os

import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_port_open(host):
    sock = host.socket("tcp://0.0.0.0:9200")
    assert sock.is_listening


def test_elastalert_running(host):
    cmd = host.run("systemctl status elastalert")
    assert cmd.rc == 0


def test_cerebro_running(host):
    cmd = host.run("systemctl status cerebro")
    assert cmd.rc == 0


def test_cerebro_port_open(host):
    sock = host.socket("tcp://0.0.0.0:9000")
    assert sock.is_listening
