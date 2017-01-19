#!/bin/bash
# Copyright (c) 2012-2016 Codenvy, S.A.
# All rights reserved. This program and the accompanying materials
# are made available under the terms of the Eclipse Public License v1.0
# which accompanies this distribution, and is available at
# http://www.eclipse.org/legal/epl-v10.html
#

cmd_test() {
  debug $FUNCNAME

  if container_exist_by_name $CHE_SERVER_CONTAINER_NAME; then
    CURRENT_CHE_SERVER_CONTAINER_ID=$(get_server_container_id $CHE_SERVER_CONTAINER_NAME)
    if container_is_running ${CURRENT_CHE_SERVER_CONTAINER_ID} && \
       server_is_booted ${CURRENT_CHE_SERVER_CONTAINER_ID}; then

        # Not loaded as part of the init process to save on download time
        load_utilities_images_if_not_done
        docker_run -it ${UTILITY_IMAGE_CHETEST} "$@"

       return
    fi
  fi

  info "test" "The system is not running."
}
