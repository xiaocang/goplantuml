VERSION := $(shell cat VERSION)
COMMIT_SHA := $(shell git rev-parse --short HEAD 2>/dev/null || echo "unknown")
GO_VERSION := $(shell go version | cut -d ' ' -f 3)
BINARY_NAME := goplantuml

.PHONY: all build clean test

all: build

build:
	@echo "Building $(BINARY_NAME) $(VERSION)-$(COMMIT_SHA)"
	@go build -ldflags="-X 'main.version=$(VERSION)-$(COMMIT_SHA)'" -o $(BINARY_NAME) cmd/goplantuml/main.go
	@echo "Build complete: $(BINARY_NAME) version $(VERSION)-$(COMMIT_SHA) with $(GO_VERSION)"

test:
	@echo "Running tests..."
	@go test ./...

clean:
	@echo "Cleaning up..."
	@rm -f $(BINARY_NAME)

install: build
	@echo "Installing $(BINARY_NAME)..."
	@mv $(BINARY_NAME) $(GOPATH)/bin/
	@echo "Installation complete" 
