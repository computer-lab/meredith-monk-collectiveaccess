# meredith-monk-collectiveaccess

Meredith Monk / House Foundation Collective Access setup.

Based on [these Dockerfiles](https://github.com/artturimatias/CollectiveAccess),
but using docker-compose for managing services.

## Google Cloud Setup

1. Set up Compute Engine VM with Ubuntu
2. Go to VPC Network -> External IP addresses, and set the IP address for the VM
   you just created as "Static"
3. Create a MySQL instance. On the "Overview" page, follow the instructions to
   "Connect from a Compute Engine VM Instance". Make sure both the Compute
   Engine VM and your development machine are whitelisted for access to the
   database.
4. Download `.env` file or populate one with the connection information for the
   new database.
5. SSH into the compute engine vm. Install docker and docker compose based on
   [these instructions](https://docs.mattermost.com/install/prod-docker.html).
6. Clone this repo onto the compute engine vm, and copy the `.env` to the
   project root.
7. Run the service with `docker-compose up -d`, then attach to the container
   with `docker exec -it collectiveaccess /bin/bash`, and make sure permissions
   are set properly for the `/var/www/providence/media` directory by executing
   `chown -R www-data /var/www/providence/media` and `chgrp -R www-data
   /var/www/providence/media`.
