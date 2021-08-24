# RoseTTAFold Docker
Docker image for the RoseTTAFold system from the UW Baker Lab.


## Building the Docker Image
```sh
docker build -t rosetta .
docker run --name rosetta -it rosetta
# docker exec -it rosetta /bin/bash
```

## Running the Monomer Structure Prediction on 