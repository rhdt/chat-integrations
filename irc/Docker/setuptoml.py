from os import environ

irc_chan = environ['IRC_CHANNEL_NAMES'].split(",")
mm_chan = environ['MM_CHANNEL_NAMES'].split(",")
counter = 1
o = open("matterbridge.toml",'a')
print irc_chan, mm_chan
for x,y in zip(irc_chan, mm_chan):
    o.write("\n[[gateway]]\nname=\"gateway%d\"\nenable=true\n" %counter)
    counter+=1
    o.write("    [[gateway.inout]]\n    account=\"irc.freenode\"\n    channel=\"%s\"\n" %x)
    o.write("    [[gateway.inout]]\n    account=\"mattermost.work\"\n    channel=\"%s\"\n" %y)
o.close()
    
