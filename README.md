# meredith-monk-collectiveaccess

Meredith Monk / House Foundation Collective Access setup.

Based on [these Dockerfiles](https://github.com/artturimatias/CollectiveAccess),
but using docker-compose for managing services.

## Google Cloud Setup

1. Set up Compute Engine VM with Ubuntu
2. Go to VPC Network -> External IP addresses, and set the IP address for the VM
   you just created as "Static"
3. Create a MySQL instance. On the "Overview" page, follow the instructions to
   "Connect from a Compute Engine VM Instance"
