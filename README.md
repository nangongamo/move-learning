# move-learning

本仓库是我个人学习 Move 语言的学习计划、路径及总结，特将此形成一套初学者入门教程，希望对大家有帮助。

**输出不易，请右上角来个 Star，让更多人的能看到。谢谢！**



------

## Move 环境

安装步骤

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



**[Windows]**

[Windows 系统下配置 Move 开发环境](./doc/00-installation-win.md)



## Move 基础

[01. 编写 HelloWorld](./doc/01-hello-world.md)

[02. 基本数据类型学习](./doc/02-move-basic-1.md)

[03. 理解 Move 包和模块](./doc/03-move-basic-2.md)

[Move 其他语法](https://move-language.github.io/move/introduction.html)



**标准库**

- Option

  >Move 中的 `option` 用来在程序运行过程中表达`有（1）`和`无（0）`的概念。像某些编程语言在代码中还需要处理 Null 值问题，不然抛出空指针异常。但对于主打安全的 Move 智能合约来说这是要去避免的，类似解决 `Null` 空指针问题，当然 Move 中是没有 `Null`关键字。



[示例 BasicCoin](./code/BasicCoin)