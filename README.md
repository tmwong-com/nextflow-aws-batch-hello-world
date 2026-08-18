# `nextflow-aws-batch-hello-world`

`nextflow-aws-batch-hello-world` provides a complete Nextflow pipeline example to test Batch setups in the Xella environment. It uses "[your first Nextflow script](https://www.nextflow.io/docs/latest/your-first-script.html)" so you can watch a basic Nextflow piepline use the new Batch environment.

## Prerequisites

- An AWS profile with access to a Xella Nextflow Batch cluster that includes:
  - A Batch queue
  - A bucket in which both you and Batch can read and write Nextflow artifacts.
- [Docker](https://docs.docker.com/desktop/). Required to run the pipeline locally.
- [Nextflow](https://www.nextflow.io/docs/latest/install.html)

## Usage

1. Log into your AWS environment: `aws sso login --profile <AWS_PROFILE>`
2. Run locally: `nextflow run main.nf`
3. Run in Batch: `BATCH_JOB_QUEUE=<AWS Batch job queue> BUCKET_URI=<S3 URI at which you and Batch can read and write artifacts> make run`
4. To capture the run in a Seqera workspace, set the `TOWER` environment variables before running:
  ```bash
  export TOWER_ACCESS_TOKEN=<your token>
  export TOWER_WORKSPACE_ID=<target workspace ID>
  ```
