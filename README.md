# OPella DevOps Technical Challenge - Azure Infrastructure with Terraform

<img width="1562" height="822" alt="pella_azure_architecture drawio" src="https://github.com/user-attachments/assets/a64448ff-9a88-460e-a31b-800d2f07292c" />

## Overview

This repository provisions Azure infrastructure using Terraform with a reusable and maintainable Infrastructure as Code structure.

The solution includes:

- a reusable Terraform module for Azure Virtual Network provisioning
- separate `dev` and `prod` environments
- a Linux Virtual Machine
- a Storage Account and private Blob container
- remote Terraform state stored in Azure Storage
- GitHub Actions workflows for validation and planning
- clean-code tooling with formatting, linting, security checks, and documentation automation

The design aims to demonstrate:

- module reuse
- environment isolation
- security awareness
- scalability
- maintainability
- CI/CD readiness

---

## Architecture Summary

This solution is structured in two layers:

### 1. Reusable module
The `modules/vnet` module provisions:

- Azure Virtual Network
- Subnets
- Optional Network Security Groups
- NSG rules
- NSG-to-subnet association
- Standard outputs for downstream reuse

### 2. Environment-specific root configurations
The `environments/dev` and `environments/prod` folders consume the reusable VNet module and deploy:

- Resource Group
- VNet and subnets
- Linux Virtual Machine
- Storage Account
- Private Blob container

---

## Why separate environment folders?

I used separate environment folders for `dev` and `prod` because this approach provides:

- clearer separation of long-lived environments
- separate Terraform state per environment
- simpler CI/CD targeting
- lower risk of applying changes to the wrong environment
- flexibility if production later needs stricter controls, different regions, or separate subscriptions

Terraform workspaces can also provide separate state, but for long-lived environments like dev and prod, explicit environment folders are often easier to manage and safer in practice.

---

## Resource Groups vs Subscriptions

For this challenge, I used:

- **one Azure subscription**
- **separate resource groups per environment**

Examples:
- `rg-pella-dev-eastus`
- `rg-pella-prod-eastus`

### Why this approach?
This keeps the solution simple, practical, and compatible with Azure free tier, while still providing clear lifecycle separation between environments.

### What I would do in a larger enterprise setup
In a production enterprise environment, I would typically consider:

- separate subscriptions for dev and prod
- stricter RBAC boundaries
- environment-specific Azure Policy assignments
- stronger billing and governance separation

---

## Environment Design

### Dev
- Resource Group: `rg-pella-dev-eastus`
- VNet: `vnet-pella-dev-eastus`
- Address space: `10.10.0.0/16`
- VM subnet: `10.10.1.0/24`
- App subnet: `10.10.2.0/24`
- Linux VM with public IP for easier testing
- Storage Account with private blob container

### Prod
- Resource Group: `rg-pella-prod-eastus`
- VNet: `vnet-pella-prod-eastus`
- Address space: `10.20.0.0/16`
- VM subnet: `10.20.1.0/24`
- App subnet: `10.20.2.0/24`
- Linux VM without public IP
- stricter NSG rule for SSH
- Storage Account with private blob container

---

## Architecture Diagram

```text
Azure Subscription
│
├── Resource Group: rg-pella-dev-eastus
│   ├── VNet: vnet-pella-dev-eastus (10.10.0.0/16)
│   │   ├── Subnet: vm  (10.10.1.0/24)
│   │   │   ├── NSG attached
│   │   │   ├── NIC
│   │   │   ├── Linux VM
│   │   │   └── Public IP (dev only)
│   │   └── Subnet: app (10.10.2.0/24)
│   └── Storage Account + Private Blob Container
│
└── Resource Group: rg-pella-prod-eastus
    ├── VNet: vnet-pella-prod-eastus (10.20.0.0/16)
    │   ├── Subnet: vm  (10.20.1.0/24)
    │   │   ├── NSG attached
    │   │   ├── NIC
    │   │   └── Linux VM (no public IP)
    │   └── Subnet: app (10.20.2.0/24)
    └── Storage Account + Private Blob Container

