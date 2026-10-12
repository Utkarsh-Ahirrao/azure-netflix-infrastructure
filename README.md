# 🎬 Azure Netflix DevOps Platform

### 🚀 Infrastructure as Code \| Microsoft Azure \| Terraform \| Azure DevOps

A Netflix-inspired frontend demo hosted on Microsoft Azure, with cloud
infrastructure managed through Terraform and an Azure DevOps workflow.

This portfolio project demonstrates practical DevOps concepts such as
Infrastructure as Code (IaC), reusable Terraform modules, remote state
management, Git branching, pull requests, and controlled infrastructure
deployment.

> **Project scope:** This is a Netflix-inspired frontend demo, not a
> complete Netflix clone. It does not implement Netflix's production
> backend, authentication, subscription management, or streaming
> platform.

------------------------------------------------------------------------

## 📌 Table of Contents

-   [🎯 Project Overview](#-project-overview)
-   [🏗️ Architecture](#️-architecture)
-   [🛠️ Tech Stack](#️-tech-stack)
-   [☁️ Azure Resources](#️-azure-resources)
-   [📂 Terraform Project Structure](#-terraform-project-structure)
-   [⚙️ Azure DevOps Pipeline
    Workflow](#️-azure-devops-pipeline-workflow)
-   [🌿 Git Branching Strategy](#-git-branching-strategy)
-   [🔐 Security Practices](#-security-practices)
-   [🚀 Deployment Workflow](#-deployment-workflow)
-   [🧪 Validation and Testing](#-validation-and-testing)
-   [🛠️ Challenges and Solutions](#️-challenges-and-solutions)
-   [📚 Key Learnings](#-key-learnings)
-   [🔮 Future Improvements](#-future-improvements)
-   [👨‍💻 Author](#-author)

------------------------------------------------------------------------

## 🎯 Project Overview

The Azure Netflix DevOps Platform combines a Netflix-inspired frontend
demo with Terraform-managed Azure infrastructure.

Instead of creating every cloud resource manually through the Azure
Portal, the infrastructure is defined as code. Azure DevOps is used to
run infrastructure workflow tasks, while Git branches and pull requests
help control changes before they reach the main branch.

### ✨ Key Highlights

-   ☁️ Define and provision Azure infrastructure using Terraform.
-   🧩 Organize infrastructure using reusable Terraform modules.
-   🌐 Configure Azure virtual networking, subnets, and network security
    rules.
-   🖥️ Host a frontend-only demo on an Azure Virtual Machine.
-   🔄 Use Azure DevOps YAML pipelines for Terraform workflow tasks.
-   🦾 Run pipeline jobs using a self-hosted Windows agent.
-   🌿 Follow a feature branch → Pull Request → `main` workflow.
-   🗄️ Store Terraform state remotely in Azure Blob Storage.
-   🔐 Practise secure credential handling and controlled access to
    Azure resources.

------------------------------------------------------------------------

## 🏗️ Architecture

The workflow connects source control, Terraform execution, Azure DevOps,
and the target Azure environment.

``` mermaid
flowchart TD
    A[Developer] --> B[Feature Branch]
    B --> C[Azure Repos]
    C --> D[Terraform Validation and Plan]
    D --> E[Pull Request]
    E --> F[Review and Approval]
    F --> G[Merge into Main]
    G --> H[Terraform Apply Workflow]
    H --> I[Self-Hosted Agent]
    I --> J[Microsoft Azure]
    J --> K[Resource Group]
    K --> L[Virtual Network and Subnet]
    L --> M[Network Security Group]
    K --> N[Public IP and Virtual Machine]
    K --> O[Storage Account]
    N --> P[Netflix-Inspired Frontend]
    O --> Q[Terraform Remote State]
```

### 🔄 How It Works

1.  Infrastructure changes are developed in a feature branch.
2.  Changes are pushed to Azure Repos.
3.  Terraform validation and planning are run through the configured
    workflow.
4.  A Pull Request is created so the changes can be reviewed.
5.  After the required review and approval, the changes are merged into
    `main`.
6.  The main-branch workflow applies infrastructure changes according to
    its YAML configuration.
7.  The pipeline authenticates to Azure using the configured service
    connection and permissions.
8.  Terraform creates or updates resources based on the configuration.

The Azure Blob Storage backend stores Terraform state outside the local
working directory, allowing subsequent Terraform runs to access the same
state.

------------------------------------------------------------------------

## 🛠️ Tech Stack

  Category                 Technology
  ------------------------ -------------------------------------------------------
  Cloud platform           Microsoft Azure
  Infrastructure as Code   Terraform
  CI/CD and automation     Azure DevOps Pipelines
  Source control           Git and Azure Repos
  Compute                  Azure Virtual Machine
  Networking               Azure Virtual Network, Subnet, Network Security Group
  Remote state             Azure Blob Storage
  Command-line tools       Azure CLI and Terraform CLI
  Pipeline agent           Self-hosted Windows agent
  Application              Netflix-inspired frontend demo

Security scanning tools such as **tfsec**, **TFLint**, and **Checkov**
can be included where they are configured in the repository's actual
workflow.

------------------------------------------------------------------------

## ☁️ Azure Resources

The infrastructure configuration includes the following resource types.
Confirm the actual resource names and settings in the Terraform files
before documenting specific values.

### 1. Resource Group

-   Groups related Azure resources in one logical container.
-   Simplifies resource organization and lifecycle management.

### 2. Virtual Network (VNet)

-   Provides a private network for Azure resources.
-   The project configuration has used the address space `10.0.0.0/16`;
    confirm this against the current Terraform files.

### 3. Subnet

-   Divides the virtual network into a smaller network segment.
-   The project configuration has used `10.0.1.0/24`; confirm this
    against the current Terraform files.

### 4. Network Security Group (NSG)

-   Controls inbound and outbound traffic through configured security
    rules.
-   Rules should allow only the access required for the deployment.

### 5. Public IP Address

-   Provides a public endpoint for the virtual machine when configured.
-   Public access should be restricted using suitable network security
    rules.

### 6. Storage Account

-   Provides Azure Blob Storage for the Terraform remote-state backend.
-   Keeps the state file separate from the local project directory.

### 7. Azure Virtual Machine

-   Provides the compute environment for the frontend demo.
-   Application access depends on the VM setup, application service, and
    network configuration.

------------------------------------------------------------------------

## 📂 Terraform Project Structure

The infrastructure is organized into a root/parent module and reusable
child modules. Adjust this example to match the exact directory names in
the repository.

``` text
azure-netflix-infrastructure/
├── Parent-Module/
│   └── Dev/
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       ├── outputs.tf
│       ├── providers.tf
│       └── backend.tf
├── Child-Modules/
│   ├── resource-group/
│   ├── virtual-network/
│   ├── subnet/
│   ├── network-security-group/
│   ├── public-ip/
│   ├── storage-account/
│   └── virtual-machine/
├── .gitignore
├── .terraform.lock.hcl
└── README.md
```

> The directory tree is illustrative. Keep only files and folders that
> actually exist in your repository, and use the exact capitalization of
> their names.

### 🧩 Why Use Terraform Modules?

Modules separate infrastructure into smaller, reusable components. For
example, a network module can manage a virtual network, while a separate
module can manage a virtual machine.

This approach helps keep the configuration organized and makes
individual components easier to maintain, troubleshoot, and extend.

------------------------------------------------------------------------

## ⚙️ Azure DevOps Pipeline Workflow

Azure DevOps runs the infrastructure workflow using YAML pipeline
definitions and the configured self-hosted agent.

### 🔹 Terraform Validation and Plan

The validation/planning workflow can include these steps, depending on
the current YAML configuration:

1.  **Checkout** --- Retrieves the repository code.
2.  **Terraform Init** --- Initializes Terraform and the configured
    backend and providers.
3.  **Terraform Validate** --- Checks the configuration for syntax and
    structural errors.
4.  **Terraform Plan** --- Previews the infrastructure changes Terraform
    intends to make.
5.  **Pull Request review** --- Allows changes to be reviewed before
    merging.

### 🔹 Terraform Apply

The main-branch workflow is intended to apply infrastructure changes
after the required review and merge process. The exact steps depend on
the current pipeline YAML.

A typical apply workflow may:

1.  Check out the merged code.
2.  Initialize Terraform.
3.  Validate the configuration.
4.  Generate or review a Terraform plan.
5.  Apply the intended changes when the required conditions and
    approvals are satisfied.

Only describe approvals, validation tasks, or security scans as enabled
if they are actually configured in the pipeline.

### 🦾 Self-Hosted Agent

The project uses a self-hosted Windows agent pool named `Agent007`.

The agent executes Azure DevOps pipeline jobs, including Terraform
commands.

**Why use a self-hosted agent?**

-   🖥️ Control over the build and execution environment.
-   🧰 Ability to install required tools such as Terraform and Azure
    CLI.
-   🔧 Practical experience configuring and troubleshooting an agent.

### 🔗 Azure Service Connection

The configured Azure DevOps service connection is named
`agent-azlz-pr1`.

It provides the pipeline with a configured authentication path to Azure.
The identity behind the connection must have the permissions required
for the operations performed by the pipeline.

------------------------------------------------------------------------

## 🌿 Git Branching Strategy

The project uses a feature-branch and Pull Request workflow to manage
infrastructure changes.

``` text
Feature branch
      |
      v
Push changes to Azure Repos
      |
      v
Terraform validation and plan
      |
      v
Create Pull Request
      |
      v
Review and approval
      |
      v
Merge into main
      |
      v
Main-branch apply workflow
      |
      v
Azure infrastructure
```

### 🌱 Create a Feature Branch

``` bash
git checkout -b feature/update-infrastructure
```

### 📤 Commit and Push Changes

``` bash
git add .
git commit -m "Update Terraform infrastructure"
git push -u origin feature/update-infrastructure
```

### 🔍 Create a Pull Request

Create a Pull Request from the feature branch into `main`. Review the
changes and complete any required checks before merging.

### 🔒 Main Branch Protection

Direct pushes to `main` are restricted by the configured Azure Repos
branch policies. This encourages review and controlled changes to the
infrastructure code.

------------------------------------------------------------------------

## 🔐 Security Practices

Security should be considered throughout infrastructure development and
deployment.

-   🔑 **Credential management:** Keep credentials in protected pipeline
    variables or an appropriate secret store; do not commit them to Git.
-   🛡️ **Azure RBAC:** Grant the service-connection identity only the
    permissions it needs.
-   🚫 **Git hygiene:** Exclude local Terraform directories, state
    files, and sensitive configuration from source control.
-   📋 **Pull Request review:** Review infrastructure changes before
    merging them into `main`.
-   🔎 **Security scanning:** Use tools such as tfsec or Checkov when
    configured in the pipeline.
-   🧹 **Linting:** Use TFLint when configured to catch potential
    Terraform configuration issues.
-   🌐 **Network security:** Restrict inbound traffic using appropriate
    NSG rules.
-   🗄️ **Remote-state protection:** Limit access to the Azure Storage
    account and Terraform state container.

### Important Security Notes

-   Never commit passwords, client secrets, storage access keys, or
    other credentials.
-   Keep `.terraform.lock.hcl` in version control to help maintain
    provider dependency consistency.
-   Terraform state can contain sensitive values; do not publish it.
-   Protect pipeline secrets and restrict who can run
    infrastructure-changing pipelines.
-   Avoid exposing SSH access to the entire internet when a more
    restrictive rule is possible.

------------------------------------------------------------------------

## 🚀 Deployment Workflow

### ☁️ Infrastructure Deployment

``` text
Terraform configuration
          ↓
Azure Repos
          ↓
Validation and Plan
          ↓
Pull Request Review
          ↓
Merge into main
          ↓
Terraform Apply workflow
          ↓
Azure resources
```

Terraform defines the infrastructure, while Azure DevOps manages the
configured execution workflow.

### 🎬 Frontend Application

The Netflix-inspired frontend demo has been run on an Azure Virtual
Machine. The VM provides the environment where the frontend is hosted.

Docker image publishing, Azure Container Registry integration, and
automated application deployment should be listed as completed features
only after they have been implemented and verified.

------------------------------------------------------------------------

## 🧪 Validation and Testing

The following commands are useful for validating Terraform
configuration. Run them from the correct Terraform root module.

  -----------------------------------------------------------------------
  Command                             Purpose
  ----------------------------------- -----------------------------------
  `terraform fmt -recursive`          Formats Terraform files
                                      consistently.

  `terraform init`                    Initializes the working directory,
                                      providers, and backend.

  `terraform validate`                Checks configuration syntax and
                                      structure.

  `terraform plan`                    Previews proposed infrastructure
                                      changes.
  -----------------------------------------------------------------------

Additional checks can include:

-   **Security scanning:** Identify potential infrastructure
    misconfigurations using a configured scanner.
-   **Azure resource verification:** Confirm that expected resources
    exist and have the intended settings.
-   **Application access check:** Verify that the frontend responds at
    its configured endpoint.

> Review the Terraform plan before applying changes. Run
> `terraform apply` only when the proposed changes are understood and
> authorized.

------------------------------------------------------------------------

## 🛠️ Challenges and Solutions

### 1. Terraform Module Dependencies

**Challenge:** Resources such as subnets, network security groups, and
virtual machines depend on correct resource relationships.

**Solution:** Organized resources into modules and corrected the
relevant references and dependencies.

### 2. Network Security Group Association

**Challenge:** The NSG must be associated with the appropriate network
component.

**Solution:** Corrected the NSG association configuration and checked
the resource relationships.

### 3. Virtual Machine Authentication

**Challenge:** VM authentication settings must meet Azure requirements
without exposing sensitive credentials.

**Solution:** Adjusted the VM configuration and handled sensitive inputs
through the intended variables and pipeline configuration.

### 4. Terraform Remote State

**Challenge:** Terraform state needed to be available across runs
instead of relying only on local state.

**Solution:** Configured an Azure Storage backend using a storage
account, blob container, and state key.

### 5. Protected Main Branch

**Challenge:** Direct pushes to `main` were rejected by Azure Repos
branch policies.

**Solution:** Used a feature branch and Pull Request workflow to review
and merge changes.

### 6. Self-Hosted Agent Execution

**Challenge:** Pipeline execution depends on the agent environment,
installed tools, and Azure authentication.

**Solution:** Configured the `Agent007` Windows agent and worked through
the required Terraform and Azure CLI setup.

These experiences helped develop practical troubleshooting skills across
Terraform, Azure networking, Git workflows, and Azure DevOps.

------------------------------------------------------------------------

## 📚 Key Learnings

Through this project, I practised:

-   ☁️ Provisioning and managing Azure resources.
-   🧱 Building reusable Terraform modules.
-   🌐 Configuring virtual networks, subnets, NSGs, public IPs, and
    virtual machines.
-   🗄️ Managing Terraform remote state with Azure Blob Storage.
-   ⚙️ Working with Azure DevOps YAML pipelines.
-   🦾 Configuring and troubleshooting a self-hosted agent.
-   🔗 Connecting Azure DevOps to Azure through a service connection.
-   🌿 Using Git branches, Pull Requests, and branch policies.
-   🔐 Applying security practices to infrastructure code and pipeline
    credentials.
-   🛠️ Troubleshooting configuration and pipeline execution issues.

------------------------------------------------------------------------

## 🔮 Future Improvements

Potential enhancements for future iterations include:

-   🐳 Containerize the frontend using Docker.
-   📦 Publish the application image to Azure Container Registry.
-   🔄 Automate application deployment through a dedicated CI/CD
    pipeline.
-   🌐 Configure a custom domain and HTTPS.
-   🛡️ Add an appropriate application entry point, such as Azure
    Application Gateway, if required by the architecture.
-   🔎 Add or expand pull-request security and code-quality checks.
-   📊 Integrate monitoring, logging, and health checks.
-   🏗️ Explore a more secure multi-tier architecture.
-   🤖 Explore GitHub Actions as an additional CI/CD option.

These are future enhancements, not claims that every feature is already
implemented.

------------------------------------------------------------------------

## 👨‍💻 Author

**Utkarsh Ahirrao**

*Junior DevOps Engineer \| Microsoft Azure \| Terraform \| Azure DevOps
\| CI/CD*

I am building practical skills in cloud infrastructure, automation,
deployment pipelines, and DevOps security through hands-on projects.

🔗 **GitHub:** [Utkarsh-Ahirrao](https://github.com/Utkarsh-Ahirrao)

⭐ Feedback and suggestions are welcome.

------------------------------------------------------------------------

## 📄 Disclaimer

This is an educational portfolio project created to practise DevOps
concepts. It is not affiliated with, endorsed by, or sponsored by
Netflix.

Azure resources may incur charges. Review resource usage and remove
resources that are no longer needed.
