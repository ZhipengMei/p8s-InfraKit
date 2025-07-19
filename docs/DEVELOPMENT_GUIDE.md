# Development Guide

This guide provides instructions for setting up your local development environment for the `P8S-InfraKit` project.

## Developer Onboarding

### 1. Install Dependencies

The first step is to install all the necessary tools and dependencies. We have a script that automates this process.

```bash
./scripts/install_deps.sh
```

### 2. Authenticate with GitHub

To push your changes to the remote repository, you will need to authenticate with GitHub. The easiest way to do this is with the official GitHub CLI (`gh`).

```bash
gh auth login
```

### 3. Initialize Your Local Git Repository

This project uses pre-commit hooks to enforce code quality and consistency. To get everything set up, you will need to initialize a local Git repository and install the hooks.

**Navigate to the `P8S-InfraKit` Directory**

```bash
cd P8S-InfraKit
```

**Install the Pre-Commit Hooks**

```bash
pre-commit install
```

**Make Your First Commit**

```bash
git add .
git commit -m "Initial commit"
```

After you've run these commands, your local Git repository will be fully set up, and your pre-commit hooks will be active.
