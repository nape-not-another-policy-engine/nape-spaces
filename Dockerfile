FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    build-essential \
    curl \
    git \
    libssl-dev \
    pkg-config \
    python3 \
    python3-pip \
    cmake
    
# Install Rust using rustup, which installs both rustc and cargo
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y

# Ensure that cargo and rustc are in the PATH
ENV PATH="/root/.cargo/bin:${PATH}"

RUN pip install --upgrade pip
RUN pip install nape

RUN git clone https://github.com/nape-not-another-policy-engine/nape.git /source_code/nape
WORKDIR /source_code/nape
RUN make build-release
RUN make install

RUN git clone https://github.com/nape-not-another-policy-engine/nape-tutorials.git /tmp/tutorials

RUN mkdir -p ~/nape-lab/tutorials && mv /tmp/tutorials/* ~/nape-lab/tutorials

RUN rm -rf /tmp/tutorials
RUN rm -rf /source_code

WORKDIR /root

CMD ["bash"]