FROM alpine:3.16 as builder
ENV PATH=$PATH:/usr/local/go/bin \
    GOLANG_VERSION=${GOLANG_VERSION:-1.17.13}
RUN apk add --update --no-cache \
    go \
    gcc \
    bash \
    curl \
    musl-dev \
    openssl-dev \
    ca-certificates && \
    update-ca-certificates && \
    curl -L "https://go.dev/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz" | tar -C /usr/local -xzf - && \
    cd /usr/local/go/src && \
    ./make.bash && \
    apk del go && \
    go version

FROM alphaceti/deploy-default:0.1.8-alpine3.17
ENV PATH="/usr/local/go/bin:${PATH}"
COPY --from=builder /usr/local/go/ /usr/local/go/
RUN apk add --update --no-cache \
    aws-cli && \
    go get k8s.io/client-go@latest
