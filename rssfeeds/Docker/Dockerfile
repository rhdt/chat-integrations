FROM registry.devshift.net/osio-prod/base/python2:latest

# clone the upstream source repo
RUN git clone https://github.com/bitbackofen/Rss-Atom-Feed-Integration-for-Mattermost &&\
    cd Rss-Atom-Feed-Integration-for-Mattermost && git checkout 8e189eb &&\
    pip install -r requirements.txt

RUN mv Rss-Atom-Feed-Integration-for-Mattermost/settings.py.docker Rss-Atom-Feed-Integration-for-Mattermost/settings.py

WORKDIR Rss-Atom-Feed-Integration-for-Mattermost

CMD python feedfetcher.py
