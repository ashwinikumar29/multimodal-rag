.PHONY: start install_deps install_sys_deps_mac install_sys_deps_linux run_redis run_chromadb run_notebooks run_all clean

# Main command to set up everything and run services
start: install_deps install_sys_deps run_all

# Install Python dependencies
install_deps:
	@echo "Installing Python dependencies..."
	pip install -r requirements.txt

# Install system-level dependencies for macOS
install_sys_deps_mac:
	@echo "Installing system-level dependencies for macOS..."
	@if ! command -v wget >/dev/null 2>&1; then \
		echo "Installing wget..."; \
		brew install wget; \
	fi
	@if ! command -v redis-server >/dev/null 2>&1; then \
		echo "Installing Redis..."; \
		brew install redis; \
	fi
	@if ! command -v tesseract >/dev/null 2>&1; then \
		echo "Installing Tesseract..."; \
		brew install tesseract; \
	fi
	@if ! command -v pdftoppm >/dev/null 2>&1; then \
		echo "Installing Poppler..."; \
		brew install poppler; \
	fi

# Install system-level dependencies for Linux
install_sys_deps_linux:
	@echo "Installing system-level dependencies for Linux..."
	sudo apt-get update
	sudo apt-get install -y wget redis-server tesseract-ocr poppler-utils

# Determine the operating system and install system-level dependencies
install_sys_deps:
	@echo "Detecting OS and installing system-level dependencies..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		$(MAKE) install_sys_deps_mac; \
	else \
		$(MAKE) install_sys_deps_linux; \
	fi

# Start Redis with health check
run_redis:
	@echo "Starting Redis server..."
	@if ! command -v redis-server >/dev/null 2>&1; then \
		echo "Redis not found. Installing Redis..."; \
		if [ "$$(uname)" = "Darwin" ]; then \
			brew install redis; \
		else \
			sudo apt-get update && sudo apt-get install -y redis-server; \
		fi \
	fi
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew services start redis || redis-server & \
	else \
		sudo service redis-server start || redis-server & \
	fi
	@echo "Waiting for Redis to start..."
	@sleep 3
	@if redis-cli ping > /dev/null 2>&1; then \
		echo "Redis started successfully"; \
	else \
		echo "Redis failed to start"; \
		exit 1; \
	fi

# Start ChromaDB
run_chromadb:
	@echo "Starting ChromaDB..."
	@if command -v chroma >/dev/null 2>&1; then \
		chroma run & \
		sleep 5 && curl -s http://localhost:8000/api/v1/heartbeat || echo "ChromaDB failed to start"; \
	else \
		echo "Error: ChromaDB not installed. Please install ChromaDB first."; \
		exit 1; \
	fi

# Cleanup processes
clean:
	@echo "Cleaning up processes..."
	@if [ "$$(uname)" = "Darwin" ]; then \
		brew services stop redis || pkill -f redis-server; \
	else \
		sudo service redis-server stop || pkill -f redis-server; \
	fi
	@pkill -f chroma || true
	@echo "Services stopped"

# Start Jupyter Notebook
run_notebooks:
	@echo "Starting Jupyter Notebook..."
	jupyter notebook

# Run all services together
run_all:
	@echo "Starting Redis, ChromaDB, and Jupyter Notebook..."
	$(MAKE) run_redis
	sleep 5
	$(MAKE) run_chromadb
	sleep 5
	$(MAKE) run_notebooks