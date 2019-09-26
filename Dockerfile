FROM debian:buster
RUN apt-get -y update

RUN apt-get -y install \
    curl \
    tar \
    cmake \
    make \
    gcc \
    gdb \
    g++ \
    libboost-all-dev

WORKDIR /usr/src/lib-tdt
COPY . ./
RUN mkdir build && \
  cd build && \
  export CMAKE_BUILD_PARALLEL_LEVEL=$(($(nproc)*4)) && \
  cmake .. -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -DCMAKE_BUILD_TYPE=Release && \
  cmake --build . --clean-first --config Release
