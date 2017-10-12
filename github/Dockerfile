FROM registry.centos.org/centos/centos:7

# Install dependencies for mattermost-integration-github
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install python-pip git && \
    pip install --upgrade pip && \
    yum clean all

# Install mattermost-integration-github
RUN pip install git+https://github.com/softdevteam/mattermost-github-integration@92394f2

# copy config file
COPY config.py /opt/

# set env variables
ENV FLASK_APP=mattermostgithub MGI_CONFIG_FILE=/opt/config.py

EXPOSE 5000

CMD flask run --host=0.0.0.0
