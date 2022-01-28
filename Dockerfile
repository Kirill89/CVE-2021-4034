FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Install gcc compiler.
RUN apt update && apt install -y gcc

# Install vulnerable version of policykit and the dependencies (0.105-26ubuntu1 is vulnerable).
RUN apt install -y libpolkit-gobject-1-0=0.105-26ubuntu1 libpolkit-agent-1-0=0.105-26ubuntu1 policykit-1=0.105-26ubuntu1

# Create user to demonstrate privilege escalation.
RUN groupadd -g 1111 user && useradd --home /tmp -u 1111 -g user -s /bin/sh user
USER user

# Copy the exploit files to /tmp/exploit.
RUN mkdir /tmp/exploit
COPY evil-lib.c pkexec-wrapper.c gain-root.sh /tmp/exploit

# Start the container in the /tmp/exploit folder from the "user" user.
ENTRYPOINT ["/bin/sh", "-c", "cd /tmp/exploit && /bin/bash"]
