from os import environ                                                                                                                             
from sys import exit
USERNAME = "Github"
ICON_URL = ""
reponames = [x for x in environ['REPO_NAMES'].split(',')]
hook_urls = [x for x in environ['HOOK_URLS'].split(',')]
channels = [x for x in environ['CHANNEL_NAMES'].split(',')]

MATTERMOST_WEBHOOK_URLS = {}

if not( len(reponames) == len(hook_urls) == len(channels)):
    exit(1)

#   MATTERMOST_WEBHOOK_URLS.update( reponame : ( url, channel)
for x in xrange(len(channels)):
    MATTERMOST_WEBHOOK_URLS.update({reponames[x] : (hook_urls[x], channels[x])})

SECRET = ""
SHOW_AVATARS = True
SERVER = {
    'hook': "/",
    'address': "0.0.0.0",
    'port': 5000,
}

