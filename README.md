# Github Action for Google Cloud Run

An GitHub Action for deploying revisions to Google Cloud Run.

## Usage

In your actions workflow, somewhere after the step that builds
`gcr.io/<your-project>/<image>`, insert this:

```bash
- name: Deploy service to Cloud Run
  uses: jmn/action-cloud-run@2cf11f7b354806593b20dafc96778882bc185abd
  with:
    image: gcr.io/[your-project]/[image]
    service: [your-service]
    project: [your-project]
    region: [gcp-region]
    env: ${{ secrets.ENV_BASE64 }}
    service key: ${{ secrets.GCLOUD_AUTH }}
```

Your `GCLOUD_AUTH` secret (or whatever you name it) must be a base64 encoded
gcloud JSON service key with the following permissions:
- Service Account User
- Cloud Run Admin
- Cloud Run Service Agent

The image must be "pushable" to one of Google's container registries, i.e. it
should be in the `gcr.io/[project]/[image]` or `eu.gcr.io/[project]/[image]`
format.

The `env` input is optional.
