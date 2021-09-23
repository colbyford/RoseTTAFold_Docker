# RoseTTAFold Docker

Docker container image for the RoseTTAFold system from the UW Baker Lab.

<h4 align="right">Colby T. Ford, Ph.D.</h4>

## Building the Docker Image

```bash
docker build -t rosetta .
docker run --name rosetta -it rosetta
# docker exec -it rosetta /bin/bash
```

This can take over an hour just to install all the dependencies and download the reference data.

## Running the Monomer Structure Prediction in the Container

```bash
./run_pyrosetta_ver.sh input.fa .
```

## Notes
- This image requires a GPU that is compatible with CUDA 11.
- You will have to download the large amount of supporting data, either within the container or have it available on your local machine and mount the storage.
- You will need to increase the resource limits in Docker's settings to support this image.
