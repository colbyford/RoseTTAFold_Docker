# RoseTTAFold Docker
Docker image for the RoseTTAFold system from the UW Baker Lab.

<h3 align="right">Colby T. Ford, Ph.D.</h3>

## Building the Docker Image
```bash
docker build -t rosetta .
docker run --name rosetta -it rosetta
# docker exec -it rosetta /bin/bash
```

## Running the Monomer Structure Prediction in the Container

```bash
./run_pyrosetta_ver.sh input.fa .

```

## Notes
- This image requires a GPU that is compatible with CUDA 11.
- You will have to download the large amount of supporting data, either within the container or have it available on your local machine.
- You will need to increase the resources limits in Docker's settings to support this image.
