#!/bin/bash

# Show command before executing
set -x

# Exit on error
set -e

function login() {
  if [ -n "${DEVSHIFT_USERNAME}" -a -n "${DEVSHIFT_PASSWORD}" ]; then
    docker login -u ${DEVSHIFT_USERNAME} -p ${DEVSHIFT_PASSWORD} ${REGISTRY}
  else
    echo "Could not login, missing credentials for the registry"
  fi
}

export BUILD_TIMESTAMP=`date -u +%Y-%m-%dT%H:%M:%S`+00:00

if [ "$TARGET" = "rhel" ]; then
    IMAGE="matterbridge"
    REGISTRY="push.registry.devshift.net"
    REPOSITORY="osio-prod"
    TAG="latest"
    BUILDER_IMAGE="matterbridge-builder"
    BUILDER_CONT="matterbridge-build-container"

    # build the bin on centos based container
    docker build Docker -f Docker/Dockerfile.build -t BUILDER_IMAGE="matterbridge-builder"
    docker run --detach=true --name ${BUILDER_CONT} -t ${BUILDER_IMAGE} /bin/tail -f /dev/null 
    docker cp ${BUILDER_CONT}:/tmp/src/github.com/42wim/matterbridge/matterbridge .

    # building the final image
    docker build Docker -f Docker/Dockerfile.rhel -t $REGISTRY/$REPOSITORY/$IMAGE:$TAG
    docker push $REGISTRY/$REPOSITORY/$IMAGE:$TAG
    if [ $? -eq 0 ]; then
      echo 'CICO: Image pushed, ready to update deployed app'
      exit 0
    else
      echo 'CICO: Image push failed'
      exit 2
    fi
else
    # Check the existence of image on registry.centos.org
    IMAGE="matterbridge"
    REGISTRY="https://registry.centos.org"
    REPOSITORY="mattermost"
    TEMPLATE="openshift/mattermost-irc-bridge.app.yaml"
    
    #Find tag used by deployment template
    echo -e "Scanning OpenShift Deployment Template for Image tag"
    TAG=$(cat $TEMPLATE | grep -A 1 "name: IMAGE_TAG_VERSION" | grep "value:" |  awk '{split($0,array,":")} END{print array[2]}')
    
    #Check if image is in the registry
    echo -e "Checking if image exists on the registry"
    TAGLIST=$(curl -X GET $REGISTRY/v2/$REPOSITORY/$IMAGE/tags/list)
    echo $TAGLIST | grep -w $TAG
    
    if [ $? -eq 0 ]; then
      echo 'CICO: Image existence check successful. Ready to deploy updated app'
      exit 0
    else
      echo 'CICO: Image existence check failed. Exiting'
      exit 2
    fi
fi
