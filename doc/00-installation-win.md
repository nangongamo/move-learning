## Windows 系统下配置 Move 开发环境

> Move 依赖 Rust 语言。



### 安装 Rust

> Rust 依赖 vc++ 库。所以会下载 Visual Studio Code软件。
>
> 注：电脑已安装 rust 的请跳过。

去 [Rust 官网](https://www.rust-lang.org) 选择适合自己电脑系统的安装包( 32 位或 64 位)，进行下载，运行安装包按命令行提示进行交互安装即可。

> 下载地址：https://www.rust-lang.org/tools/install

在控制台，输入 `rustc -V` 看到如下结果，表示安装成功了。

```bash
C:\Users\DELL>rustc -V
rustc 1.63.0 (4b91a6ea7 2022-08-08)

C:\Users\DELL>cargo -V
cargo 1.63.0 (fd9c4297c 2022-07-01)
```



**注：**

默认会安装到 `C:\Users\你的用户名\.cargo\bin\` 目录。



### 安装 Move

Rust 安装好后，我们开始安装 Move ，分别执行如下两条命令：

> 依赖 Git ，请先安装 Git ：https://git-scm.com/downloads

安装 **move-cli**

```bash
cargo install move-cli --git https://github.com/move-language/move
```

需要下载资源进行编译，耐心等待即可。

安装完成后，执行如下命令 `move -V` ：

```bash
C:\Users\DELL>move -V
move-cli 0.1.0
```

表示安装成功。

**问题**

若遇到如下错误：

> C:\Users\DELL>move -V
>
> 系统找不到指定的文件
>
> 或者提示命令语法不正确

恭喜你遇到 bug 了，这可能是 move 命令 与你电脑系统命令冲突了。

见：https://github.com/move-language/move/issues/358

建议：在安装目录下找到 `move.exe`文件，改下名。



安装 **move-analyzer**

> 分析 move 语法的

```bash
cargo install move-analyzer --git https://github.com/move-language/move move-analyzer 
```

需要下载资源进行编译，耐心等待即可。

安装完成后，执行如下命令 `move-analyzer -V` ：

```bash
C:\Users\DELL>move-analyzer -V
move-analyzer 1.0.0
```

表示安装成功。



### Move 开发者工具

推荐使用 [vscode](https://code.visualstudio.com/)

安装 vscode 后，再安装 `move-analyzer` 插件。用于在项目开发中 Move 语法高亮显示、代码补齐等便捷功能使用。



使用 **move** 创建项目：

```bash
move new hello-world
```



用 **vscode** 打开 `hello-world` 文件夹，开始编码吧。



### 引用

> https://lililikeuuu.lemonhx.moe/2022/09/05/windows_move/