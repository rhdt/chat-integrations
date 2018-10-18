FROM registry.devshift.net/osio-prod/base/python2:latest

# Install mattermost-integration-github
RUN pip install git+https://github.com/softdevteam/mattermost-github-integration@acb6833

# copy config file
COPY config.py /opt/

# set env variables
ENV FLASK_APP=mattermostgithub MGI_CONFIG_FILE=/opt/config.py

EXPOSE 5000

CMD flask run --host=0.0.0.0
