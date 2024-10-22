# Setting Up Environment

## Install Python Dependencies
```shell
pip install langchain
pip install langchain-openai
pip install langchain-chroma
pip install langchain-community
pip install langchain-experimental
pip install "unstructured[all-docs]"
pip install htmltabletomd
pip install redis
```

## Install System-level Dependencies
1. Install tesseract-ocr - https://tesseract-ocr.github.io/tessdoc/Installation.html
*   For macOS
  ```shell
  brew install tesseract
  ```
*   For Ubuntu
  ```shell
  sudo apt-get install tesseract-ocr
  ```
2. Install Poppler -
*   For macOS
  ```shell
  brew install poppler
  ```
*   For Ubuntu
  ```shell
  sudo apt-get install poppler-utils
  ```

## Install Vectorstore
```shell
pip install chromadb
chroma run
```

## Install Docstore
Follow instructions - https://redis.io/docs/latest/operate/oss_and_stack/install/install-redis/