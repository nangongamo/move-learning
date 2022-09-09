## 变量与常量

### 变量

变量定义使用 `let` 关键字。例如：

```bash
let v = 0;
debug::print(&v);
```

未使用的变量，变量名要以下划线（`_`）开头标记，例如：

```
let _v = 0;
```

**变量确定类型**

- 在变量名右侧添加`:`，紧接着跟上变量类型。
- 在变量的赋值内容的右侧直接跟上变量的类型，不需要 `:`。

如下代码所示

```move
let n1:u64;
n1 = 1000;
let n2 = 1000u64;
```



### 常量

常量定义使用 `const` 关键字。例如：

```move
const U64_MAX:u128 = 18446744073709551615;
```

> 常量只能定义在模块或脚本中，不能定义在函数内。常量只允许大写字母开头，



## 基本数据类型

Move 语言原始的基本数据类型：`u8`、`u64`、`u128`、`boolean`、`address`

> Move 语言原始类型中是没有`字符串`和`浮点数`的，后面增加了 `string` 和 `fixed_point32` 模块进行扩展。



### 整型

> 整型除了 `u8`、`u64`、`u128`，实际应用场景可能需要 `u256`，Move 官方目前未支持 `u256` ，但社区项目 ( [starcoin](https://github.com/starcoinorg/) ) 有贡献 `u256` 的实现，后面再介绍。

**u8**：uint8, 也就是无符号 8 位整数范围，即 2 的 8 次方减 1 的 10 进制范围。

> 最大值：255

**u64**：uint64, 也就是无符号 64 位整数范围，即 2 的 64 次方减 1 的 10 进制范围。

> 最大值：18446744073709551615

**u128**：uint128, 也就是无符号 128 位整数范围，即 2 的 128 次方减 1 的 10 进制范围。

> 最大值：340282366920938463463374607431768211455

**u256**：uint256, 也就是无符号 256 位整数范围，即 2的 256 次方减一的 10 进制范围。

> 最大值：115792089237316195423570985008687907853269984665640564039457584007913129639936

```move
let u8_max:u8 = 255;
let u64_max:u64 = 18446744073709551615;
let u128_max:u128 = 340282366920938463463374607431768211455;

debug::print(&u8_max);
debug::print(&u64_max);
debug::print(&u128_max);
```

输出结果：

```bash
[debug] 255
[debug] 18446744073709551615
[debug] 340282366920938463463374607431768211455
```



### 布尔值

布尔类型值就两个：`true` 和 `false` ，即一个状态值，要么真（ `true` ）要么假（ `false` ）。

```move
let b1:bool = true;
let b2 = false;
let b3 = (n1==n2);

debug::print(&b1);
debug::print(&b2);
debug::print(&b3);
```

输出结果：

```bash
[debug] true
[debug] false
[debug] true
```

### 地址

**Address** 是区块链中账户模型里面的账户地址，即账户标识符或者是区块链操作者（发送者）标识符。

**address 定义**

```move
let addr:address;
addr = @myAddress;

debug::print(&addr);
```

输出结果：

```bash
[debug] 0000000000000000000000000a550c18
```

**注：**

> 地址定义在项目下的 `.toml` 文件中，例如上述代码中的 `myAddress`。

见 **Move.toml** 文件

```toml
[package]
name = "02-move-basic-1"
version = "0.0.0"

[dependencies]
MoveStdlib = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib", rev = "main" }
MoveNursery = { git = "https://github.com/move-language/move.git", subdir = "language/move-stdlib/nursery", rev = "main" }

[addresses]
std =  "0x1"
myAddress = "0x0000000000000000000000000a550c18"
```



### 类型转换

> 整型类型之间的强制转换。

例如，定义 `u8` 类型变量 `a` 与 `u64` 类型的 `b`，将 `b` 与 `a` 相除。即如下代码所示： 

```move
let a = 100u8;
let b = 66600u64;
let c = b / a; 
debug::print(&c);
```

结果 **运行报错**，一个 `u8` ，一个 `u64` ，两者做数学运算抛出错误，类型不兼容。

调整后的代码如下：

```move
let a = 100u8;
let b = 66600u64;
let c = b / (a as u64);
debug::print(&c);
```

结果：

```bash
[debug] 666
```

这里用到了 `as` 关键字来进行显示强转操作。



------



所有完整的代码在此：[02-move-basic-1](./../code/02-move-basic-1)





## 总结

- 未使用的变量，变量名要以下划线（`_`）开头标记。

- 常量要以大写字母开头。常量只能定义在模块或脚本中，不能定义在函数内。

- 目前 Move 整型除了官方原生的 `u8`、`u64`、`u128`，还有社区扩展的`u256`。

- 目前 Move 语言中无负数。

- 不同类型的整型进行数学运算时要进行类型转换，使用 `as` 关键字。

- Move 语言中没有像传统编程语言那样的字符串类型，虽有提供 `string` 模块，但都是基于 `vector` 类型进行封装的，

  且内容也都是进行 `ASCII` 编码的（我们后面再针对字符串做详细介绍）。

- Move 浮点数操作可以使用 `fixed_point32` 模块（我们后面再针对字符串做详细介绍）。