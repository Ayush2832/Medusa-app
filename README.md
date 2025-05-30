Deploying Medusa app in ecs using terraform and github actions.

- First I go to the official medusa site and setup it locally.
- Then I run it using docker contaier using the docker image in the repo. Port it used is 9000
- Once all things are configured then I simply write terraform files for all the infrastructure.
- Then simply run terraform apply
- Now we have to put the dump in the new rds container
- Then we create new database and export the dump there.
- Then we simply change the rds endpoint in the .env file
- And we also copy the json from ecs task definiton and paste the medusa-task.json file
- Then we configure the github actions and then push the code and dpeloyment is comptly fine.
