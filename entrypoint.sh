#!/bin/sh

set -e

echo "$INPUT_SERVICE_KEY" | base64 --decode > "$HOME"/gcloud.json

if [ "$INPUT_ENV" ]
then
    ENVS=$(echo "$INPUT_ENV" | base64 --decode | awk '{printf $0 " "}' | sed 's/ /,/g')
    ENV_FLAG="--set-env-vars $ENVS"
fi

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT"

echo "---- ENV_FLAG----"
echo "$ENV_FLAG"
echo "---- END ENV_FLAG ----"

gcloud run deploy "$INPUT_SERVICE" \
  --image "$INPUT_IMAGE" \
  --region "$INPUT_REGION" \
  --platform managed \
  --project "$INPUT_PROJECT" \
  --allow-unauthenticated \
  ${ENV_FLAG}
