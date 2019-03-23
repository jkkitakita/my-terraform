# Copyright 2016 Philip G. Porada
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

.ONESHELL:
.SHELL := /bin/bash
.PHONY: apply apply-auto-approve destroy destroy-target plan-destroy plan plan-target init
CURRENT_FOLDER=$(shell basename "$$(pwd)")
CATEGORY_FOLDER=$(shell pwd | rev | awk -F\/ '{print $$2}' | rev)
BUCKET_PREFIX="$(CATEGORY_FOLDER)"
WORKSPACE="$(CURRENT_FOLDER)-$(ENV)"
BOLD=$(shell tput bold)
RED=$(shell tput setaf 1)
GREEN=$(shell tput setaf 2)
YELLOW=$(shell tput setaf 3)
RESET=$(shell tput sgr0)

# fix backend gcs
GCP_BACKEND_PROJECT="sample"
GCP_BACKEND_BUCKET="sample-dev-tfstate"
GCP_BACKEND_REGION="us-west1"
GCP_BACKEND_CREDENTIALS="$(HOME)/.config/gcloud/$(GCP_BACKEND_PROJECT).json"

ifeq ($(ENV),prd)
	GCP_PROJECT="sample-prd"
	GCP_CREDENTIALS="$(HOME)/.config/gcloud/$(GCP_PROJECT).json"
else ifeq ($(ENV),qa)
	GCP_PROJECT="sample"
	GCP_CREDENTIALS="$(HOME)/.config/gcloud/$(GCP_PROJECT).json"
else
	GCP_PROJECT="sample"
	GCP_CREDENTIALS="$(HOME)/.config/gcloud/$(GCP_PROJECT).json"
endif

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

set-env:
	@if [ -z $(ENV) ]; then \
		echo "$(BOLD)$(RED)ENV was not set. ex. ENV=dev make plan$(RESET)"; \
		exit 1; \
	 fi
	@if [ ! -e $(GCP_BACKEND_CREDENTIALS) ]; then \
		echo "$(BOLD)$(RED)'$(GCP_BACKEND_CREDENTIALS)' not found.$(RESET)"; \
		exit 1; \
	 fi

init: set-env
	@terraform init \
		-backend-config="project=$(GCP_BACKEND_PROJECT)" \
    -backend-config="bucket=$(GCP_BACKEND_BUCKET)" \
    -backend-config="region=$(GCP_BACKEND_REGION)" \
    -backend-config="prefix=$(CATEGORY_FOLDER)" \
    -backend-config="credentials=$(GCP_BACKEND_CREDENTIALS)"
	@echo "$(BOLD)Switching to workspace $(WORKSPACE)$(RESET)"
	@terraform workspace select $(WORKSPACE) || terraform workspace new $(WORKSPACE)
	@echo "CATEGORY_FOLDER: $(CATEGORY_FOLDER)"

plan: init ## Show what terraform thinks it will do
	@terraform plan \
		-lock=true \
		-input=false \
		-refresh=true \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS) \
		| tfnotify --config="../../tfnotify.yaml" plan

plan-target: init ## Shows what a plan looks like for applying a specific resource
	@echo "$(YELLOW)$(BOLD)[INFO]   $(RESET)"; echo "Example to type for the following question: google_project.this_project"
	@read -p "PLAN target: " DATA && \
		terraform plan \
			-lock=true \
			-input=true \
			-refresh=true \
			-target=$$DATA \
			-var gcp_credentials=$(GCP_CREDENTIALS) \
			-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS) \
			| tfnotify --config="../../tfnotify.yaml" plan

plan-destroy: init ## Creates a destruction plan.
	@terraform plan \
		-input=false \
		-refresh=true \
		-destroy \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS) \
		| tfnotify --config="../../tfnotify.yaml" plan

apply: init ## Have terraform do the things. This will cost money.
	@terraform apply \
		-lock=true \
		-input=false \
		-refresh=true \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS) \
		| tfnotify --config="../../tfnotify.yaml" apply

apply-auto-approve: init ## Have terraform do the things. This will cost money.
	@terraform apply --auto-approve \
		-lock=true \
		-input=false \
		-refresh=true \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS) \
		| tfnotify --config="../../tfnotify.yaml" apply

destroy: init ## Destroy the things
	@terraform destroy \
		-lock=true \
		-input=false \
		-refresh=true \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS)

destroy-target: init ## Destroy a specific resource. Caution though, this destroys chained resources.
	@echo "$(YELLOW)$(BOLD)[INFO] Specifically destroy a piece of Terraform data.$(RESET)"; echo "Example to type for the following question: module.rds.aws_route53_record.rds-master"
	@read -p "Destroy target: " DATA && \
		terraform destroy \
		-lock=true \
		-input=false \
		-refresh=true \
		-target=$$DATA \
		-var gcp_credentials=$(GCP_CREDENTIALS) \
		-var gcp_backend_credentials=$(GCP_BACKEND_CREDENTIALS)
