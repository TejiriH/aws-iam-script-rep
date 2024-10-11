#! /bin/bash

# A shell script to create 5 IAM users and a group and attach a policy to this group and then add the users to the group

users=("mandy" "grace" "faith" "love" "truth")

Create_IAM_users(){

        # command to filter an individual name from the array of names
	for user in "${users[@]}"; do

        #aws cli to create the users and filter error output to the null folder
        aws iam create-user --user-name $user 2> /dev/null

        # if condition to echo the status of the create command whether successful or not
        if [ $? -eq 0 ]; then
                echo "IAM user $user created successfully."
        else
                echo "IAM user $user not created successfully."
        fi
	done
}

# function to create group on aws

Create_IAM_group(){
	# aws cli command to create user group and filter error to null folder
	aws iam create-group --group-name  Admins 2>/dev/null
	if [ $? -eq 0 ]; then 
	echo "Admins group created successfully"
	else
	echo "Admins group failed to create"
	fi
}


# function to attach AWS managed admin policy

Attach_admin_policy_to_group(){
	# function to attach aws managed policy to the above created group "Admins"
	aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --group-name Admins
}


# function to add users to admin group
Add_user_to_group(){
	# for loop to pick out from the array of names above individual names to assign to the group until it completes

	for user in "${users[@]}"; do

	aws iam add-user-to-group --user-name $user --group-name Admins 2> /dev/null

	# if condition to echo the status of the create command whether successful or not
        if [ $? -eq 0 ]; then
                echo "IAM user $user assigned to Admins group successfully."
        else
                echo "IAM user $user failed to be assigned to Admins group."
        fi
	done
}






Create_IAM_users
Create_IAM_group
Attach_admin_policy_to_group
Add_user_to_group
