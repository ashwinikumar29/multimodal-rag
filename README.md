
# **Multimodal RAG Workshop**

This workshop demonstrates how to set up, run, and experiment with Multimodal Retrieval-Augmented Generation (RAG) models. This document outlines all the steps needed to install the dependencies, start the required services, and run Jupyter notebooks.

## **Table of Contents**
1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
    - [Installing Python Dependencies](#installing-python-dependencies)
    - [Installing System-Level Dependencies](#installing-system-level-dependencies)
3. [Starting Redis and ChromaDB](#starting-redis-and-chromadb)
4. [Running Jupyter Notebooks](#running-jupyter-notebooks)
5. [Platform-Specific Setup](#platform-specific-setup)
    - [macOS Setup](#macos-setup)
    - [Linux Setup](#linux-setup)
    - [Windows Setup](#windows-setup)
6. [Troubleshooting](#troubleshooting)

## **Prerequisites**

Ensure you have the following installed on your machine:

- Python 3.8+
- pip (Python package installer)

## **Installation**

### **1. Installing Python Dependencies**

Run the following command to install all Python packages:

```bash
pip install -r requirements.txt
```

### **2. Installing System-Level Dependencies**

#### **macOS and Linux:**

Use the provided `Makefile` to install system-level dependencies:

1. **Install dependencies and start services:**
   ```bash
   make start
   ```

The `make start` command will install Python dependencies, system-level packages, and start Redis, ChromaDB, and Jupyter Notebook.

#### **Windows:**
- **Tesseract-OCR:** Download the [Windows installer](https://github.com/tesseract-ocr/tesseract/releases) and follow the instructions.
- **Poppler:** Download Poppler for Windows from [this link](http://blog.alivate.com.au/poppler-windows/), and add the binary path to the system’s environment variables.

## **Starting Redis and ChromaDB**

Redis and ChromaDB are essential components of the setup, acting as document and vector stores, respectively.

### **1. Start Redis and ChromaDB**

Use the following command to start all services together:

```bash
make run_all
```

Alternatively, you can start Redis and ChromaDB separately using:

```bash
make run_redis
make run_chromadb
```

#### **Windows:**
- Open a new terminal and navigate to the directory where Redis is installed.
  ```bash
  redis-server.exe
  ```
- In another terminal, run:
  ```bash
  chroma run
  ```

## **Running Jupyter Notebooks**

To launch the Jupyter notebooks:

1. Navigate to the directory containing the notebooks:
   ```bash
   cd <your-notebook-directory>
   ```
2. Start the Jupyter Notebook server:
   ```bash
   make run_notebooks
   ```
3. In your browser, open and run the following notebooks:
   - `multimodal-rag.ipynb`
   - `traditional-rag.ipynb`

## **Platform-Specific Setup**

### **macOS Setup**

Run the following command to set up everything:

```bash
make start
```

### **Linux Setup**

Run the following command to set up everything:

```bash
make start
```

### **Windows Setup**

Follow these steps to manually install and run each component:

1. **Install Python dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
2. **Install Tesseract-OCR and Poppler as outlined in the installation section.**
3. **Start Redis and ChromaDB as outlined above.**
4. **Run Jupyter Notebook using:**
   ```bash
   jupyter notebook
   ```

## **Troubleshooting**

- **Redis Server Not Starting:** Ensure Redis is correctly installed and not blocked by any firewall.
- **ChromaDB Issues:** Make sure you have the latest version of ChromaDB installed. You may need to restart it if the server fails.
- **Jupyter Notebook Not Opening:** Check if the port is already in use or blocked by your firewall. Restart Jupyter Notebook if needed.

For any other issues, please check the logs or refer to the documentation of each tool.
