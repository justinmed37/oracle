# Tools for OCI DevOps

> Moved lots of design content that was here to the PR: https://github.com/justinmed37/oracle/pull/9

## Genesis

This is the proposed DevOPS solution - emphasis on Operations is intentional.

There are a multitude of use cases for building automation capable of making dynamic changes to infrastructure.

Where **Terraform** is the blueprint of our Software Defined Architecture...
...the ***DevOPS*** system transforms those blueprints into easily-managed components

...

Put more simply, it's a **"devops worker"**, that can be scheduled, or programmed, to do **"things"** a DevOps Engineer would normally be needed for.

**Like...**
- Turning the lights out when we "leave for the day" - aka shut off dev resources that cost money
    - Containers
    - Databases

## Primary Use Cases

1. **DevOps Operator**
    - Whoever is operating the infrastructure, needs a straight-forward, simple, development environment from which to perform their daily operations.
    - I want to discontinue using the UI for prototyping, but the API and Terraform are still clunky for rapid work. This fills a huge need both in prototyping, and vastly simplified engineer onboarding
1. **DevOps Autobot**
    - Application components are exposed as automation "friendly" functions
    - Enables Developers to write simple and intuitive policies for managing their components
    - Uses:
        - Start/Stop resources based on schedules
        - Automate disaster recovery scenarios (changing load balancer configs, etc...)
        - Scale resources based on metrics


## Current State
There are two **runtime** modes for this tool set.

- Local: Runs in a local docker container for development. Uses individual user ~/.oci/config.
- Remote: Runs in a container or function in OCI. Uses resource principal auth.
    - These Remote functions will primarily be called / invoked from GitHub Actions

## Notes

1. To run the container localy with users .oci/config do:
    - ```docker build --tag oci-devops:0``` 
    - ```alias ocipython='docker run -it --rm --mount type=bind,source=$HOME/.oci,target=/root/.oci --name my-running-script -v "$PWD":/usr/src/devops -w /usr/src/devops oci-devops:0 /bin/bash "$@"'```