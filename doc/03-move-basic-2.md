> Move 相关概念：包、模块及其使用

## 包

Move 包（package）概念，简单点理解，例如我们用 IDE 创建一个 Move 目录并包含一个`.toml` 文件和含`sources` 目录的源文件，这整个目录就是一个包。而且一个目录下同样可以再创建子目录，子目录中符合上述描述的，也同样是一个包。包的清单都定义在了 `Move.toml` 文件中。

例如：使用 move-cli 工具创建一个 Move 项目（包），如下

```bash
move new myPackage
```

```
myPackage
├── sources
└── Move.toml
```

上面 `myPackage` 整个目录（工程）就是一个包。`sources` 和 `Move.toml` 是必须的。

上述是一个精简的包结构，下面这个是比较完整点的包结构。

```
a_move_package
├── Move.toml      (required)
├── sources        (required)
├── examples       (optional, test & dev mode)
├── scripts        (optional)
├── doc_templates  (optional)
└── tests          (optional, test mode)
```

> 更详细见：https://move-language.github.io/move/packages.html



**注：** Move 包的清单定义在 `Move.toml` 文件中。Move **模块**、Move **脚本**都存放在 `sources`下。

**包**允许 Move 程序员更轻松地重用代码并在项目之间共享。



**Move.toml** 文件

```toml
[package]
# 包名，例如： "myPackage"
name = <string>
# 版本号，例如： "0.0.1"
version = "<uint>.<uint>.<uint>"
# 许可协议，例如： "MIT", "GPL", "Apache 2.0"
license* = <string>
# 作者，例如： ["nangongamo (nangongamo@outlook.com)", "web3builder (web3builder@outlook.com)"]
authors* = [<string>]

[addresses]  
# 定义地址（addresses）变量，例如, Std = "_" 或者 Addr = "0x1"
<addr_name> = "_" | "<hex_address>" 

[dependencies] 
# 可以定义一个或多个依赖包。
# 本地依赖
<package_name> = { local = <string>, addr_subst* = { (<string> = (<string> | "<hex_address>"))+ } } 
# git 远程依赖
<package_name> = { git = <git URL地址>, subdir=<git 仓库里包含 .toml 文件的目录路径>, rev=<commit 哈希值>, addr_subst* = { (<string> = (<string> | "<hex_address>"))+ } } 
```



## 模块

**模块**（`module`）是定义在地址（`address`）下的。所以说模块是发布在特定地址下的打包在一起的一组函数和结构体。

模块以`module`关键字开头，后面跟随模块名称和大括号，大括号中放置模块内容。

但是我们在写 `Move` 代码时有两种写法。

- 写法1

  `address <地址变量名> {  module <模块名>{	} } `

  例如，新建文件 `my_module1.move`，如下代码：

  ```move
  address std {
      module math1 {
          public fun add(n1:u64, n2:u64):u64 {
              n1 + n2
          }
  
          #[test]
          fun test_add() {
              let n1:u64 = 1;
              let n2:u64 = 99;
              let n3:u64 = std::math1::add(n1, n2);
              assert!(n3==100u64,1000);
          }
      }
  }
  ```

- 写法2

  `module  <地址变量名>::<模块名> {	}	`

  例如，新建文件 `my_module2.move`，如下代码：

  ```move
  module std::math2 {
      public entry fun add(n1:u64, n2:u64):u64 {
          n1 + n2
      }
  
      #[test]
      fun test_add() {
          let n1:u64 = 1;
          let n2:u64 = 99;
          let n3:u64 = std::math2::add(n1, n2);
          assert!(n3==100u64,1000);
      }
  }
  ```



单元测试，执行如下命令：

```bash
move test
```

结果：

```bash
INCLUDING DEPENDENCY MoveStdlib
BUILDING 03-move-basic-2
Running Move unit tests
[ PASS    ] 0x1::math2::test_add
[ PASS    ] 0x1::math1::test_add
Test result: OK. Total tests: 2; passed: 2; failed: 0
```



## 使用

### 模块的使用

模块的使用，可以在模块（`module`）中导入模块，也可以在脚本（`script`）中导入模块。要访问导入的模块的方法或类型，需要使用::符号。

- 直接使用，例如：使用 0x1 地址下的标准库 debug 的打印函数（第3行）。

  ```
  script {
      fun main(num: u8) {
          0x1::debug::print(&num);
      }
  }
  ```

  

- 使用 use 关键字导入

  `use <Address>::<ModuleName>`

  > `<Address>` 是模块发布者的地址，`<ModuleName>` 是模块的名字

  例如：

  ```
  script {
  	use 0x1::debug;
  	
      fun main(num: u8) {
          debug::print(&num);
      }
  }
  ```



### 包的使用

主要是讲下关于 Move 包的依赖。分两种：

- 一种是依赖远程 git 仓库的 Move 包。
- 一种是依赖本地 Move 包。

依赖关系都是在 Move 包的 `Move.toml` 文件中定义的。



**依赖远程 git 仓库**

这种使用场景较频繁，特别是做项目基本都会依赖一些标准库。例如，Move 官方的标准库。

在 `Move.toml` 文件中增加如下配置，即：

```toml
[dependencies]
MoveStdlib = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib", rev = "main" }
```

解释：

**MoveStdlib** 是指你要依赖的包的**包名**（即 toml 文件中的 package name ）。

**git** 参数对应的值，是需要依赖的包的 git 仓库地址。

**subdir** 参数对应的值，是指具体需要依赖的包的目录。

> 例如，move-language 仓库下面有很多 Move 包，这里我们只使用 `move-stdlib`，所以就写对应的包目录。

**rev** 参数对应的值，是指 git 仓库的版本，例如，这里是指它使用 main 主分支，也可以填写一串哈希值（即 commit hash）。



**依赖本地的**

我们 Move 项目或包下面可能会建多个子目录（其他独立的 Move 包）。那么就会存在本地依赖的问题，比如我需要用到当前项目下的其他 Move 包。

同样，也是在 `Move.toml` 文件中配置，语法格式如下：

```toml
[dependencies]
<package_name> = { local = <string>, addr_subst* = { (<string> = (<string> | "<hex_address>"))+ } } 
```

我们来测试下。

在当前已有的 Move 包下，新个新的 Move 包。

```bash
move new mySubPackage
```

并在 `mySubPackage` 下的 sources 目录下，新建 `math3.move` 文件，内容如下：

```bash
module std::math3 {

    public fun multiply(n1:u64, n2:u64): u128 {
        (n1 as u128) * (n2 as u128)
    }

    #[test]
    fun test_multiply() {
        let num:u128 = std::math3::multiply(10u64, 20u64);
        assert!(num==200u128, 1000);
    }
}
```

OK，我们一个新的 Move 包就创建好了。接下来我们在其他包中，采用`本地依赖`的方式来依赖这个新创建的包。

即在需要依赖的包的 Move.toml 文件中，增加如下代码：

```toml
[dependencies]
MySubPackage= { local = "./MySubPackage" }
```

> local 的值就是包的目录的相对路径

然后，在当前包的 `sources` 目录下新建个`invoke_module.move` 文件来导入 MySubPackage 包下的`math3`模块，代码如下：

```move
script {

    use 0x1::math3;

    fun invoke() {
        let n1:u64 = 99;
        let n2:u64 = 100;
        let n3:u128 = math3::multiply(n1, n2);
        assert!(n3==9900u128, 1000);
    }

}
```

使用move sandbox 执行下上面的 move 文件进行验证下。OK，验证成功。



------



所有完整的代码在此：[03-move-basic-2](./../code/03-move-basic-2)