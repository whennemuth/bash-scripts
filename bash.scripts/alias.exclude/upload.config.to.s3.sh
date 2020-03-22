cd /c/whennemuth/scrap/s3 && \
dos2unix sb/core/environment.variables.s3 && aws s3 cp sb/core/environment.variables.s3 s3://kuali-research-ec2-setup/sb/core/ && \
dos2unix sb/core/local.js && aws s3 cp sb/core/local.js s3://kuali-research-ec2-setup/sb/core/ && \
dos2unix sb/kc/kc-config.xml && aws s3 cp sb/kc/kc-config.xml s3://kuali-research-ec2-setup/sb/kuali/main/config/ && \
\
dos2unix ci/core/environment.variables.s3 && aws s3 cp ci/core/environment.variables.s3 s3://kuali-research-ec2-setup/ci/core/ && \
dos2unix ci/core/local.js && aws s3 cp ci/core/local.js s3://kuali-research-ec2-setup/ci/core/ && \
dos2unix ci/kc/kc-config.xml && aws s3 cp ci/kc/kc-config.xml s3://kuali-research-ec2-setup/ci/kuali/main/config/ && \
\
dos2unix qa/core/environment.variables.s3 && aws s3 cp qa/core/environment.variables.s3 s3://kuali-research-ec2-setup/qa/core/ && \
dos2unix qa/core/local.js && aws s3 cp qa/core/local.js s3://kuali-research-ec2-setup/qa/core/ && \
dos2unix qa/kc/kc-config.xml && aws s3 cp qa/kc/kc-config.xml s3://kuali-research-ec2-setup/qa/kuali/main/config/ && \
\
dos2unix stg/core/environment.variables.s3 && aws s3 cp stg/core/environment.variables.s3 s3://kuali-research-ec2-setup/stg/core/ && \
dos2unix stg/core/local.js && aws s3 cp stg/core/local.js s3://kuali-research-ec2-setup/stg/core/ && \
dos2unix stg/kc/kc-config.xml && aws s3 cp stg/kc/kc-config.xml s3://kuali-research-ec2-setup/stg/kuali/main/config/ && \
\
dos2unix prod/core/environment.variables.s3 && aws s3 cp prod/core/environment.variables.s3 s3://kuali-research-ec2-setup/prod/core/ && \
dos2unix prod/core/local.js && aws s3 cp prod/core/local.js s3://kuali-research-ec2-setup/prod/core/ && \
dos2unix prod/kc/kc-config.xml && aws s3 cp prod/kc/kc-config.xml s3://kuali-research-ec2-setup/prod/kuali/main/config/