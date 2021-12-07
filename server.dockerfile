
FROM ubuntu:20.04 AS builder

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends cmake build-essential

ADD . /source/
WORKDIR /build/
RUN cmake -B . -S /source/server
RUN cmake --build .

FROM ubuntu:20.04

ENV PORT 10000
WORKDIR /tcpunch
COPY --from=builder /build/tcpunchd /tcpunch/tcpunchd

ENTRYPOINT /tcpunch/tcpunchd ${PORT}

