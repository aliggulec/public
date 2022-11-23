#!/bin/bash

db=("alarm_db"
    "dnp_db"
    "event_db"
    "function_db"
    "control_db"
    "measurement_db"
    "nfs_db"
    "opc_db"
    "modbus_db")

status=$(kubectl get pods  postgres-0 -o jsonpath="{.status.phase}")

if [ $status == "Running" ];
then

        for n in ${db[@]};
        do
                kubectl exec -i postgres-0 -- psql -d postgres -U postgres  -c "CREATE DATABASE $n OWNER postgres;"
                sleep 2
        echo $n created
        done

else
        echo "Container not ready"

fi
