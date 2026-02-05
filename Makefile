export AWS_ACCOUNT_ID=$(shell aws sts get-caller-identity --query Account --output text)
export AWS_REGION=$(shell aws configure get region)

export BATCH_JOB_QUEUE="NextGenomeSequencing"
export BUCKET_URI=

echo:
	@echo "AWS profile: ${AWS_PROFILE}"
	@echo "AWS Account ID: ${AWS_ACCOUNT_ID}"
	@echo "AWS Region: ${AWS_REGION}"
	@echo
	@echo "Batch job queue: ${BATCH_JOB_QUEUE}"
	@echo "Bucket URI: ${BUCKET_URI}"

#
# Development environment management
#

.PHONY: clean

clean:
	rm -f .nextflow.log.*
	rm -f .tf.out

#
# Nextflow pipeline
#

run:
	nextflow run main.nf \
		-ansi-log false \
		-bucket-dir ${BUCKET_URI} \
		-process.executor awsbatch \
		-process.queue ${BATCH_JOB_QUEUE}
