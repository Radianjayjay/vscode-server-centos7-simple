# vscode-server-centos7-simple

english | 中文
--- | ---
Patch VS Code Server to run on RHEL/CentOS 7 style systems. | 为 VS Code Server 提供补丁，使其可在 RHEL/CentOS 7 类系统运行。

## Quick Start | 快速开始

After each local VS Code upgrade (and server files are downloaded once), run this on the remote server:  
每次本地 VS Code 升级后（并已完成一次服务器文件下载），在远端服务器执行：

```bash
cd ~/vscode-server-centos7-simple
chmod +x ./vscode-server-centos7-simple.sh ./scripts/*.sh
sed -i 's/\r$//' ./vscode-server-centos7-simple.sh ./scripts/*.sh
./vscode-server-centos7-simple.sh
```

## Defaults | 默认路径

- `VSCODE_SERVER_DIR=~/.vscode-server`
- `VSCODE_GNU_DIR=~/.vscode-server/gnu`

## Custom Paths | 自定义路径

```bash
VSCODE_SERVER_DIR=/custom/.vscode-server \
VSCODE_GNU_DIR=/custom/gnu \
./vscode-server-centos7-simple.sh
```

## Requirements | 依赖

- `patchelf` available in `PATH`  
  `PATH` 中可用 `patchelf`
- GNU runtime files present in `VSCODE_GNU_DIR`  
  `VSCODE_GNU_DIR` 中包含 GNU 运行时文件

## What It Does | 执行内容

1. Copies GNU runtime files into `<server-dir>/gnu` when needed.  
   按需将 GNU 运行时文件复制到 `<server-dir>/gnu`。
2. If `VSCODE_GNU_DIR` already equals `<server-dir>/gnu`, it skips self-copy automatically.  
   若 `VSCODE_GNU_DIR` 已等于 `<server-dir>/gnu`，会自动跳过自拷贝。
3. Patches ELF interpreter from system loader to bundled loader.  
   将 ELF interpreter 从系统 loader 改为项目内置 loader。
4. Best-effort creates `/tmp/vscode-skip-server-requirements-check`.  
   尽力创建 `/tmp/vscode-skip-server-requirements-check`。

## Scripts | 脚本说明

- `vscode-server-centos7-simple.sh`: one-command entrypoint | 一键入口脚本
- `scripts/patch-vscode-server.sh`: core patch logic | 核心补丁逻辑
- `scripts/list-elf-interpreters.sh`: inspect current ELF interpreters | 查看当前 ELF interpreter
