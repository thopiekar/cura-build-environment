#!/bin/sh

GIT_REF="$(basename "${GIT_REF}")"

# Only tag as the latest for master
if [ "${GIT_REF}" = "master" ]; then
  if [ -z "${DOCKER_IMAGE_LATEST_TAG}" ]; then
    echo "DOCKER_IMAGE_LATEST_TAG environment variable is missing. It's expected from GitHub workflow file."
    exit 1
  fi
  EXTRA_TAG="${DOCKER_IMAGE_LATEST_TAG}"
fi

docker build -t $DOCKER_IMAGE_NAME:$GIT_REF -f docker/linux/Dockerfile.centos .
if [ -n "${EXTRA_TAG}" ]; then
  docker tag $DOCKER_IMAGE_NAME:$GIT_REF $DOCKER_IMAGE_NAME:$EXTRA_TAG
fi

echo "${DOCKER_PASSWORD}" | docker login -u "${DOCKER_USER}" --password-stdin "${DOCKER_IO}"

docker push $DOCKER_IMAGE_NAME:$GIT_REF
if [ -n "${EXTRA_TAG}" ]; then
  docker push $DOCKER_IMAGE_NAME:$EXTRA_TAG
fi

docker logout
