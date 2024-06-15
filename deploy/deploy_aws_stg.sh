#!/bin/bash

set -e

. ./deploy/shared/output_helper.sh

showInfo "1. Current Docker Information:"
sh ./deploy/shared/show_docker_status.sh

showInfo "2. Pulling Source Git Repository:"
sh ./deploy/shared/git_fetch_checkout_pull.sh "$@"

showInfo "3. Building a New Docker Image:"
sh ./deploy/shared/build_image.sh

start_downtime=$(date +%s)
showInfo "4. Running the New Docker Image:"
sh ./deploy/shared/switch_docker_image.sh

showInfo "5. Reporting Status After deploy:"
sh ./deploy/shared/show_docker_status.sh

showInfo "6. Waiting for the Setup DB:"
sh ./deploy/shared/db_rds_setup.sh

showInfo "7. Waiting for the Application to Start:"
sh ./deploy/shared/wait_for_app_rails.sh

end_downtime=$(date +%s)

echo "------------------------------------------------------------------------------------"
showInfo "8. Clean up Docker system:"
docker system prune -f
echo "------------------------------------------------------------------------------------\n"

downtime=$(($end_downtime - $start_downtime))
showSuccess "deployment Successful!"
showInfo "Downtime: ${downtime} seconds"
