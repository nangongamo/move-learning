## Linux 系统下配置 Move 开发环境

**安装步骤**

```bash
# git 克隆 move 官方仓库代码
git clone https://github.com/move-language/move.git

# 进入 move 目录，并执行如下安装脚本（环境依赖）
cd move
./scripts/dev_setup.sh -ypt

# 安装完成后，使环境变量配置生效
source ~/.profile

# 使用 cargo 安装 move
cargo install --path language/tools/move-cli

# 安装完成后，查看版本验证，或者查看帮助
move -V
move --help

# 安装 move-analyzer 语法分析工具
cargo install --path language/move-analyzer

# 验证 move-analyzer 是否安装成功
move-analyzer -V

```

>执行脚本安装的过程会比较慢，要下载一些依赖包及软件，耐心等待，最好能开 VPN 代理。
>
>同时保证账户有足够的权限( sudo )，因为安装过程中会需要创建目录。

**Move 环境配置就结束了，可以开始体验 Move 编程了。**

> 开发者工具推荐使用 [vscode](https://code.visualstudio.com/)
>
> 安装 vscode 后，再安装 `move-analyzer` 插件。用于在项目开发中 Move 语法高亮显示、代码补齐等便捷功能使用。



Move 安装过程遇到的问题汇总：[问题及解决办法记录](./00-installation-linux-err.md)

