# Tools for OCI DevOps

The initial use case for devops tools is:

- Cost Savings - Currently the demo is running 24hrs
    - OCI Functions: Write a function capable of stopping / starting infrastructure
    - Write a GitHub actions job that invokes the Function to start / stop on a schedule

## Approach

1. Starting with terraform
    - Create a special terraform that generates a data model of our infrastructure
    - Publish this terraform map as the final step in our terraform workflow
1. Python
    - Create a container that supports local development / authentication AND remote execution
    - Consume the data model published in object storage
    - The model enables us to access the ocids without iterating over all the OCI APIs listing things
    - Publish a container with database and container start/stop
1. GitHub Actions
    - Define the cron-style job here, as OCI has no native schedulers for functions
    - Executes the function to start / stop resources as defined

Technically this whole thing could be done in github actions.

However, I'm going with oci functions in order to expand on the capabilities of this platform and it's OCI integrations.

## Feature Notes

1. Client pattern defined in oci_devops/container/* and oci_devops/core.py
1. Commands can now be executed like this:
    - ```python -m oci_devops.container.get```
    - ```python -m oci_devops.container.start```
    - ```python -m oci_devops.container.stop```
1. Currently this auto-targets the one container we have defined in our infrastructure
    - More logic and targetting parameters likely to come later
1. These python module can now also be used like entry point targets for containers or functions!!!

## Notes

1. To run the container localy with users .oci/config do:
    - ```docker build --tag oci-devops:0``` 
    - ```alias ocipython='docker run -it --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci --name my-running-script -v "$PWD":/usr/src/devops -w /usr/src/devops oci-devops:0 /bin/bash "$@"'```