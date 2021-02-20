FROM registry.redhat.io/ubi8/ubi

ENV user=vscode
ENV home=/home/${user}

RUN yum -y install --disableplugin=subscription-manager \
  python3 python3-devel vim git gcc make \
  && yum --disableplugin=subscription-manager clean all

RUN useradd -u 1001 ${user} -s /bin/bash

USER ${user}
RUN pip3 install tox --user
RUN mkdir ${home}/local
RUN git clone https://github.com/lshake/bootstrap_ansible.git ${home}/local/bootstrap_ansible

WORKDIR ${home}/local/bootstrap_ansible
RUN ${home}/.local/bin/tox --notest

WORKDIR ${home}
