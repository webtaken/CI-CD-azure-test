FROM golang:1.21.1-alpine as builder

# BUILD PROCESS
# Working directory
WORKDIR /ci-cd-azure-test

# Copy go.mod and go.sum to the gptube folder
COPY go.mod ./ 
COPY go.sum ./ 

# Downloading dependencies
RUN go mod download

# Copy the source code into the image
COPY . ./

RUN go build -o /ci-cd-azure-test-build

# CMD [ "/ci-cd-azure-test-build" ]

# DEPLOY PROCESS
FROM alpine:latest

WORKDIR /home

ENV ENV_MODE=development
COPY --from=builder /ci-cd-azure-test-build /ci-cd-azure-test-build

EXPOSE 3000

ENTRYPOINT [ "/ci-cd-azure-test-build" ]