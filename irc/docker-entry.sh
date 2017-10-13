#!/bin/bash
config=/opt/matterbridge/matterbridge.toml
sed -Ei "s/IRC_NICK/`echo $IRC_NICK`/" $config
sed -Ei "s/MM_SERVER_NAME/`echo $MM_SERVER_NAME`/" $config
sed -Ei "s/MM_TEAM_NAME/`echo $MM_TEAM_NAME`/" $config
sed -Ei "s/MM_LOGIN/`echo $MM_LOGIN`/" $config
sed -Ei "s/MM_PASS/`echo $MM_PASS`/" $config

python setuptoml.py
#sed -Ei "s/IRC_CHANNEL_NAME/`echo $IRC_CHANNEL_NAME`/" $config
#sed -Ei "s/MM_CHANNEL_NAME/`echo $MM_CHANNEL_NAME`/" $config
./matterbridge
