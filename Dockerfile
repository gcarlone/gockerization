# Start from golang base image
FROM golang:alpine as builder

# COPY go.mod, go.sum and download the dependencies
COPY RootCA.crt /usr/local/share/ca-certificates/RootCA.crt
RUN update-ca-certificates

# Install git.
# Git is required for fetching the dependencies.
RUN apk update && apk add --no-cache git && apk add --no-cach bash && apk add build-base

# Setup folders
RUN mkdir /app
WORKDIR /app

# Copy the source from the current directory to the working Directory inside the container
COPY go.mod go.sum ./
RUN go mod download

COPY . .
COPY .env .

# Download all the dependencies
# RUN go get -d -v ./...

# Install the package
# RUN go install -v ./...

# Build the Go app
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o /main ./cmd/app/


# Utilizza l'immagine scratch come base
FROM scratch

# Aggiungi il binario compilato all'immagine
COPY --from=builder /main /main

# Expose port 8080 to the outside world
EXPOSE 8080
CMD [ "/main" ]
