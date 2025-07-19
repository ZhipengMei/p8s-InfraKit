# Development Guide

This guide provides instructions for setting up your local development environment for the `P8S-InfraKit` project.

## Developer Onboarding

### 1. Install Dependencies

The first step is to install all the necessary tools and dependencies. We have a script that automates this process.

```bash
./scripts/install_deps.sh
```

### 2. Configure Git for Multiple Accounts

If you use multiple Git accounts (e.g., for personal and work projects), we have a script to help you switch between them.

**Create SSH Keys**

First, create separate SSH keys for each of your accounts.

```bash
# Personal SSH Key
ssh-keygen -t rsa -b 4096 -C "your.personal.email@example.com" -f ~/.ssh/id_rsa_personal

# Work SSH Key
ssh-keygen -t rsa -b 4096 -C "your.work.email@example.com" -f ~/.ssh/id_rsa_work
```

**Add Keys to SSH Agent**

```bash
ssh-add ~/.ssh/id_rsa_personal
ssh-add ~/.ssh/id_rsa_work
```

**Add Public Keys to GitHub**

You will need to add your new public keys to your respective GitHub accounts.

*   **Personal Account**: Copy your personal public key (`cat ~/.ssh/id_rsa_personal.pub`) and add it to your personal GitHub account.
*   **Work Account**: Copy your work public key (`cat ~/.ssh/id_rsa_work.pub`) and add it to your work GitHub account.

**Configure SSH**

Create or edit your `~/.ssh/config` file and add the following:

```
# Personal account
Host github.com-personal
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_personal

# Work account
Host github.com-work
    HostName github.com
    User git
    IdentityFile ~/.ssh/id_rsa_work
```

**Use the `git-switch.sh` Script**

We have a script to easily switch between your Git configurations.

```bash
# Switch to your personal account
source ~/git-switch.sh personal

# Switch to your work account
source ~/git-switch.sh work
```

### 3. Clone the Repository

Now you can clone the repository using the SSH URL for your personal account.

```bash
git clone git@github.com-personal:ZhipengMei/p8s-InfraKit.git
```

### 4. Install Pre-Commit Hooks

This project uses pre-commit hooks to enforce code quality and consistency.

```bash
cd P8S-InfraKit
pre-commit install
```

### 5. Make Your First Commit

You are now ready to make your first commit.

```bash
git add .
git commit -m "Initial commit"
git push
