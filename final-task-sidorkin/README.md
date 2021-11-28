# final-task-sidorkin

features:
- 2 ALBs with one SSL certificate for both application and jenkins, HTTP requests being redirected (301) to HTTPS
- 2 DNS names for both application and jenkins
- ECR for central storage of the application images
- Application (wordpress) is dockerized with managed RDS/Aurora as DB server backend
- Jenkins instance (not dockerized but) with persistent volume to store pipelines/config/data, uses own ssh key to connect to the application instance for deployment
- Manual configuration for jenkins is needed only when the persistent data volume was destroyed [manual configuration includes - adding AWS/Gitlab creds, adding Gitlab/AWS plugins]

# the infrastructure is currently down (except RDS/ACM/ECR/SGs), but is ready to be deployed during the DEMO using  terraform

Application URL (wordpress itself):
https://sidorkin.ciklum-devops-academy.org/

Jenkins URL:
https://jenkins.sidorkin.ciklum-devops-academy.org/

# HOW-TO:
- changes made to the 'html' folder will be visible
(after the pipeline finishes)
under the following domain
https://sidorkin.ciklum-devops-academy.org/html5/

for ex. editing index.html inside the 'html' folder will be reflected on
https://sidorkin.ciklum-devops-academy.org/html5/index.html
(please mind the built-in caching on your browser,
using Incognito window shoud assist with this)

