## Hello World

一门编程语言的简单入门从 Hello World 开始！

> 要求已经搭建好 Move 开发环境。

**创建Move 项目（模块）**

```bash
move new 01-hello-world
```

会得到如下所示的**项目结构**：

```
01-hello-world
|----sources
|----Move.toml
```

**Move.toml** 默认初始化内容：

```toml
[package]
name = "01-hello-world"
version = "0.0.0"

[dependencies]
MoveStdlib = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib", rev = "main" }

[addresses]
std =  "0x1"
```

因为我们这里例子是要输出 `hello world` ，所以需在 `toml` 文件中新增个 package 依赖 `nursery`。

完整代码如下：

```toml
[package]
name = "01-hello-world"
version = "0.0.0"

[dependencies]
MoveStdlib = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib", rev = "main" }
MoveNursery = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib/nursery", rev = "main" }

[addresses]
std =  "0x1"

```

> `MoveNursery` 是 Move 模块的包名, 也就是 .toml 文件中的 package name 。

**sources** 目录下，新增文件 `HelloWorld.move` ，添加如下代码：

```move
script {

    use std::debug;

    fun main() {
        let hello = b"hello,world!";
        debug::print(&hello);
    }

}
```

在当前项目终端下，执行如下的命令：

- 编译

```bash
move build
```
结果：

```bash
INCLUDING DEPENDENCY MoveNursery
INCLUDING DEPENDENCY MoveStdlib 
BUILDING 01-hello-world
```

- 运行

  > 这里我们使用 Move 的沙盒来运行。

```bash
move sandbox run ./sources/HelloWorld.move
```

> windows 路径格式：
>
> .\sources\HelloWorld.move

结果：

```bash
[debug] (&) [104, 101, 108, 108, 111, 44, 119, 111, 114, 108, 100, 33]
```



注：`hello，world！` 打印的结果为何是这些数字？后面会详细介绍。

> Move 中没用字符串类型，上面定义的 hello world 是使用的 vector 字节数组来表示的，所以打印出来的都是 ASCII 值。



------



所有完整的代码在此：[01-hello-world](./../code/01-hello-world)



## 总结

1. 快速创建 Move 项目（模块），我们使用 Move 的命令行工具  `move new <project-name>`
2. 编译 Move 项目的命令，`move build`
3. 运行代码，使用 Move 的沙盒 `sandbox`，即：`move sandbox run <a move file path>`
4. 定义变量使用 `let` 关键字。
5. 需要引入外部包，需提前在项目 `toml` 文件的 `dependencies` 下添加包地址，然后在 move 代码中使用 `use` 关键字导入。
6. 开发阶段打印日志，我们使用 `debug` 模块的 `print` 函数。