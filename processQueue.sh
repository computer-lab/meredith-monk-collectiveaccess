#!/bin/bash
cd /home/ptsd/meredith-monk-collectiveaccess
echo "running task queue at $(date)" >> ./cronlog.txt
/usr/local/bin/docker-compose exec -T collectiveaccess ./var/www/providence/support/bin/caUtils process-task-queue 
