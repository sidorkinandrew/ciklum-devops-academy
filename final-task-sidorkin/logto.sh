ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${2:-sidorkin-aws-key.pem} ec2-user@$1
