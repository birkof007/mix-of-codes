#****************
# Primitive script to retrieve an image from our old Harbor and push it into our new one.
#****************
#!/bin/bash

echo "Název projektu starého Harboru"
read OLD_HARBOR_PROJECT_NAME
echo "Název image starého Harboru"
read OLD_HARBOR_IMAGE_NAME
echo "Název projektu nového Harboru"
read NEW_HARBOR_PROJECT_NAME

OLD_HARBOR_REGISTRY=YOUR_OLD_HARBOR
HARBOR_REGISTRY=YOUR_HARBOR

echo "============= Downloading Image ====================="
docker login $OLD_HARBOR_REGISTRY
docker pull $OLD_HARBOR_REGISTRY/$OLD_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME

echo "============= Tagging Image =================="
echo "docker tag $OLD_HARBOR_REGISTRY/$OLD_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME $HARBOR_REGISTRY/$NEW_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME"
docker tag $OLD_HARBOR_REGISTRY/$OLD_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME $HARBOR_REGISTRY/$NEW_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME
echo "============= Pusshing Image =================="
docker login $HARBOR_REGISTRY
docker push $HARBOR_REGISTRY/$NEW_HARBOR_PROJECT_NAME/$OLD_HARBOR_IMAGE_NAME
