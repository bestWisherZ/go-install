#!/bin/bash

# 检查是否传入版本参数
if [ -z "$1" ]; then
  echo "Usage: $0 <go_version>"
  echo "Example: $0 1.16.7"
  exit 1
fi

VERSION=$1

# 下载Go二进制文件
echo "Downloading Go version $VERSION..."
wget https://golang.org/dl/go$VERSION.linux-amd64.tar.gz

# 检查下载是否成功
if [ $? -ne 0 ]; then
  echo "Failed to download Go version $VERSION. Please check the version number and try again."
  exit 1
fi

# 解压文件到/usr/local
echo "Extracting Go tarball..."
sudo tar -C /usr/local -xzf go$VERSION.linux-amd64.tar.gz

# 移除下载的tar.gz文件
rm go$VERSION.linux-amd64.tar.gz

# 设置环境变量
echo "Setting up environment variables..."
if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
  echo "export PATH=\$PATH:/usr/local/go/bin" >> ~/.bashrc
fi

# 使更改生效
source ~/.bashrc

# 验证安装
go version

# 检查Go是否安装成功
if [ $? -ne 0 ]; then
  echo "Go installation failed."
  exit 1
fi

echo "Go version $VERSION installed successfully!"
