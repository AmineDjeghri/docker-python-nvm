# Base image
FROM python:3.11-slim

LABEL authors="aminedjeghri"

# Copy the necessary files for installation
COPY Makefile ./
COPY .nvmrc ./


# Install system dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y build-essential curl

# Install UV
RUN make install-uv

# Install NVM, Node.js and set up the environment
RUN make install-nvm
#RUN apt-get clean && apt-get autoremove --purge && apt-get autoremove

# Define default entrypoint if needed (Optional)
CMD ["/bin/bash"]
