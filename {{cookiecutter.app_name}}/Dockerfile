# Build Stage
FROM golang:{{cookiecutter.docker_build_image_version}}-alpine AS build-stage

LABEL app="build-{{cookiecutter.app_name}}"
LABEL REPO="https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}"

ENV PROJPATH=/go/src/github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}

ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin

ADD . /go/src/github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}
WORKDIR /go/src/github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}

RUN go mod tidy && \
    apk add --update alpine-sdk && \
    make build-alpine && \
    apk add --no-cache libc6-compat && \
    go get github.com/go-delve/delve/cmd/dlv

# Final Stage
FROM {{cookiecutter.docker_runtime_image}} 

ARG GIT_COMMIT
ARG VERSION
LABEL REPO="https://github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}"
LABEL GIT_COMMIT=$GIT_COMMIT
LABEL VERSION=$VERSION

ENV PATH=$PATH:/opt/{{cookiecutter.app_name}}/bin

WORKDIR /opt/{{cookiecutter.app_name}}/bin

COPY --from=build-stage /go/src/github.com/{{cookiecutter.github_username}}/{{cookiecutter.app_name}}/bin/{{cookiecutter.app_name}} /opt/{{cookiecutter.app_name}}/bin/
COPY --from=build-stage /go/bin/dlv /
RUN \
    apk --update add dumb-init  && \
    chmod +x /opt/{{cookiecutter.app_name}}/bin/{{cookiecutter.app_name}} 

# Create appuser
RUN adduser -S  {{cookiecutter.app_name}}
USER {{cookiecutter.app_name}}

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["/dlv", "--listen=:40000", "--headless=true", "--api-version=2", "exec", "/opt/{{cookiecutter.app_name}}/bin/{{cookiecutter.app_name}}"]
