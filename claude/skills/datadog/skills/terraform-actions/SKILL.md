
---
name: terraform-actions
description: Use this skill to perform terraform actions across multiple accounts
---

# Terraform actions

# Instructions for services/ infrastructure

Bash commands available:
- tfacross - runs multiple TF commands in parallel in different accounts

## Step 1
Run tfacross one to create a local ./tf_commands.sh file

## Step 2
Edit the section in the ./tf_commands.sh by adding the terraform commands you
want to run
NEVER, run "terraform apply"

## Step 3
Ask user for confirmation by outputting the changes made to the file, before
moving to step 4;

## Step 4
IF the user has given permission in the previous step,
Run the ./tf_commands.sh script 

# Instructions for environments/ infrastructure

Bash commands available:
- awswitch - switches to different AWS account

## Step 1
Run tfacross one to create a local ./tf_commands.sh file

## Step 2
Edit the section in the ./tf_commands.sh by adding the terraform commands you
want to run
NEVER, run "terraform apply"

## Step 3
Ask user for confirmation by outputting the changes made to the file, before
moving to step 4;

## Step 4
IF the user has given permission in the previous step,
Run the ./tf_commands.sh script 
