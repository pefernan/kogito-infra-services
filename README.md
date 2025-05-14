### ASYNC REPRODUCER ISSUE INSTRUCTIONS

This is based on this PR: https://github.com/apache/incubator-kie-kogito-runtimes/pull/3919

Steps to reproduce:
1.- fetch and build https://github.com/apache/incubator-kie-kogito-runtimes/pull/3919
2.- build Santander extensions:
2.1- build (`mvn clean install`) [kogito-bpmn-custom-user-task-event-listener](kogito-app-example/kogito-custom-extensions/kogito-bpmn-custom-user-task-event-listener)
2.2- build (`mvn clean install`) [kogito-bpmn-custom-user-task-lifecycle](kogito-app-example/kogito-custom-extensions/kogito-bpmn-custom-user-task-lifecycle)
3.- Build issue reproducer app:
3.1.- go to [kogito-bpmn-app-unsecured](kogito-app-example/kogito-bpmn-app-unsecured)
3.2.- build with `mvn clean install -Pbamoe-community -Pcontainer -Pbamoe-persistence-postgresql`
3.3.- verify that docker image `dev.local/kogito/kogito-bpmn-app-unsecured:1.0.0-SNAPSHOT` exists
4.- Start the docker container:
4.1.- `docker compose --profile full --profile kogito-bpmn-apps up` - BE PATIENT, it needs time and love
4.2.- when it's ready app should be running at port 8082
5.- open the `issue_reproducer_plan.jmx` in Jmeter and run it! It should be GREEN :)


# ORIGNINAL DOC HERE STARTING HERE...

# Kogito and Infrastructure services

## Create and run Kogito App (for quarkus:dev execution)
1. In "kogito-app-example/kogito-bpmn-app-unsecured" folder, run `mvn "-Pbamoe-community" "-Pbamoe-persistence-postgresql" "-Pembedded-postgresql" "-Pdevelopment" clean quarkus:dev`
2. Access the jBPM Dev-UI in [http://localhost:8080/q/dev-ui/org.jbpm.jbpm-quarkus-devui/process-instances]() to check everything is up and running.

## Build the Kogito images
1. In "kogito-app-example/kogito-bpmn-unsecured-app" folder, run `mvn "-Pbamoe-community" "-Pbamoe-persistence-postgresql" "-Pbamoe-audit" "-Pbamoe-kafka-events" "-Popentelemetry-traces-logs-metrics" "-Pcontainer" clean package` to create the Kogito app Docker image.
2. In "kogito-app-example/kogito-bpmn-secured-app" folder, run `mvn "-Pbamoe-community" "-Pbamoe-persistence-postgresql" "-Pbamoe-audit" "-Pbamoe-kafka-events" "-Popentelemetry-traces-logs-metrics" "-Poidc-security" "-Pcontainer" clean package` to create the Kogito app Docker image.

## Run the Compose
2. In the root folder "kogito-infra-services", run `docker compose --profile full --profile kogito-bpmn-apps up -d`. This will start the full stack except
   Kibana and Grafana. To include them, run `docker compose --profile full --profile kogito-bpmn-apps --profile dashboards up -d`.
3. Some predefined dashboards are contained in .\grafana folder. Add `JVM Quarkus - Micrometer Metrics-1743773888821.json` for Quarkus metrics, and `PostgreSQL Statistics-1743784368268.json` for PostgreSQL metrics.
4. Load tests for a simple Test Process are provided as jMeter plan in kogito-app-example\kogito-bpmn-app-unsecured\jmeter\Load tests.jmx.

These are the main web applications exposed in the docker-compose:
- Kogito Management Console: [http://localhost:8280/]()
- Kafka events console (based on Redpanda UI): [http://localhost:9001/]()
- PostgreSQL database: [postgresql://postgres:5432/kogito]() (user: kogito-user, password: kogito-pass)
- Jaeger UI (traces): [http://localhost:16686/]()
- Kibana: [http://localhost:5601/]()
- Grafana: [http://localhost:3000]()

## Access Kogito Management Console and connect to the runtimes
1. Access the Kogito Management Console from the web browser: [http://localhost:8280/]().
2. Add the secured runtime using the following data:
   - Alias: `kogito secured app`
   - URL: `http://localhost:8081`
   - Mark the "Force login prompt (for secured runtimes only)" checkbox.
   - User: `jdoe`
   - Password: `jdoe`
3. Add the non-secured runtime using the following data:
   - Alias: `kogito non-secured app`
   - URL: `http://localhost:8082`

## Start a process instance in the secured runtime
1. Execute the following request to get the access_token:
```
curl --location 'http://localhost:8480/realms/kie/protocol/openid-connect/token' \
    --header 'Content-Type: application/x-www-form-urlencoded' \
    --header 'Accept: application/json' \
    --data-urlencode 'client_id=kie-app' \
    --data-urlencode 'client_secret=secret' \
    --data-urlencode 'grant_type=password' \
    --data-urlencode 'username=jdoe' \
    --data-urlencode 'password=jdoe' \
    --data-urlencode 'scope=openid'
```

2. Start the process instance by sending this HTTP request: \
```
    curl --location 'http://localhost:8081/TestProcess' \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header 'x-kogito-correlationkey: 12345' \
        --data '{
        }'
```

3. Retrieve user tasks by sending this HTTP request with the access token (note that no user tasks will be returned in case there's no Auth present):
```
curl --location 'http://localhost:8081/usertasks/instance?user=jdoe' \
    --header 'Authorization: Bearer eyJhbG.........'
```

## Start a process instance in the unsecured runtime
To start a process instance, just execute this HTTP request: \
```
    curl --location 'http://localhost:8082/hiring' \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --data-raw '{
            "candidateData": {
                "name": "Jon",
                "lastName": "Snow",
                "email": "jon@snow.org",
                "experience": 5,
                "skills": ["Java", "Kogito", "Fencing"]
            },
            "expirationTime" : "PT120S",
            "throwException" : false
            }'
```
