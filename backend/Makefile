# Variables
APP_NAME := flyssh
SRC := $(shell find . -name '*.go' -not -path "./vendor/*")
PKG := ./...

# setup the environment by installing required packages
setup:
	@go install github.com/air-verse/air@latest
	@go install github.com/swaggo/swag/cmd/swag@latest
	@go install github.com/zxmfke/swagger2openapi3/cmd/swag2op@latest


swagger:
	@swag init
	@swag2op init

# Default target
all: build

# Build the application
build:
	@echo "Building $(APP_NAME)..."
	@go build -o $(APP_NAME) .

# Run the application
run: build
	@echo "Running $(APP_NAME)..."
	./$(APP_NAME)

# Run tests
test:
	@echo "Running tests..."
	@go test $(PKG) -cover

# Format the code
fmt:
	@echo "Formatting code..."
	@go fmt $(PKG)

# Tidy dependencies
tidy:
	@echo "Tidying up dependencies..."
	@go mod tidy

# Clean up
clean:
	@echo "Cleaning up..."
	@go clean
	@rm -f $(APP_NAME)

# Lint the code
lint:
	@echo "Linting code..."
	@golangci-lint run

# Install dependencies
deps:
	@echo "Installing dependencies..."
	@go mod download

# Generate
generate:
	@echo "Running go generate..."
	@go generate $(PKG)

# Vendor dependencies
vendor:
	@echo "Vendoring dependencies..."
	@go mod vendor

# Run the application in development mode
dev: clean fmt tidy build
	@echo "Starting in development mode..."
	@air

# Help message
help:
	@echo "Makefile for $(APP_NAME):"
	@echo "  make all        - Build the application (default)"
	@echo "  make build      - Build the application"
	@echo "  make run        - Run the application"
	@echo "  make test       - Run tests"
	@echo "  make fmt        - Format the code"
	@echo "  make tidy       - Tidy dependencies"
	@echo "  make clean      - Clean up"
	@echo "  make lint       - Lint the code"
	@echo "  make deps       - Install dependencies"
	@echo "  make generate   - Run go generate"
	@echo "  make vendor     - Vendor dependencies"
	@echo "  make dev        - Run the application in development mode"
	@echo "  make help       - Show this help message"

.PHONY: all build run test fmt tidy clean lint deps generate vendor dev help