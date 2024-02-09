# Use the official Ubuntu 20.04 LTS image as a base
FROM ubuntu:20.04

# Update package lists and install basic utilities
RUN apt-get update && \
    apt-get install -y \
    curl \
    nano \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory to /app (optional)
WORKDIR /app

# Define an environment variable (optional)
ENV MY_VARIABLE my_value

# Run a command (optional)
CMD ["bash"]
