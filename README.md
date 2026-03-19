# vscode-server-centos7-simple

A minimal standalone patch project for running VS Code Server on RHEL/CentOS 7 style environments.

## One-command workflow

After local VS Code upgrades and downloads server files once, run on server:

```bash
cd /path/to/vscode-server-centos7-simple
chmod +x ./vscode-server-centos7-simple.sh ./scripts/*.sh
sed -i 's/\r$//' ./vscode-server-centos7-simple.sh ./scripts/*.sh
./vscode-server-centos7-simple.sh
```

Defaults:

- `VSCODE_SERVER_DIR=~/.vscode-server`
- `VSCODE_GNU_DIR=~/.vscode-server/gnu`

If `VSCODE_GNU_DIR` is the same as `~/.vscode-server/gnu`, the patch script should skip self-copy automatically.

Override if needed:

```bash
VSCODE_SERVER_DIR=/custom/.vscode-server \
VSCODE_GNU_DIR=/custom/gnu \
./vscode-server-centos7-simple.sh
```

## Requirements

- `patchelf` available in `PATH`
- Compatible GNU runtime files under `gnu/` (or `VSCODE_GNU_DIR`)

## Files

- `vscode-server-centos7-simple.sh`: one-command entrypoint
- `scripts/patch-vscode-server.sh`: patch implementation
- `scripts/list-elf-interpreters.sh`: check interpreters
