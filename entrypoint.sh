#!/bin/sh

set -e

echo "$INPUT_SERVICE_KEY" | base64 --decode > "$HOME"/gcloud.json

gcloud auth activate-service-account --key-file="$HOME"/gcloud.json --project "$INPUT_PROJECT"

if [ "$INPUT_ENV" ]
then
    ENVS=$(echo "$INPUT_ENV" | base64 --decode | sed -r '/^\s*$/d' | tr '\n' ',' | sed 's/,*\r*$//')
    ENV_FLAG="--set-env-vars $ENVS"
    
    echo "---- ENV_FLAG----"
    echo "$ENV_FLAG"
    echo "---- END ENV_FLAG ----"
fi

gcloud run deploy "$INPUT_SERVICE" \
  --image "$INPUT_IMAGE" \
  --region "$INPUT_REGION" \
  --platform managed \
  --project "$INPUT_PROJECT" \
  --allow-unauthenticated \
  ${ENV_FLAG}
