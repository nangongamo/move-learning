## 实例 - Memories

> 基于Starcoin 公链

### 需求

**Memory 倒计时/记事本**

记录目标生日（宝宝生日）、倒计时、纪念日、备忘录、计划、大事件日历等等。让你不再错过任何一个重要的日子。



### 设计

方案一：存储在账户下

**memory 字段**

| 字段    | 释义                       | 说明                                                         |
| ------- | -------------------------- | ------------------------------------------------------------ |
| id      | 标识 id                    | 目前使用时间戳记录                                           |
| words   | 一句话，内容描述           | 内容进行 hex 编码存储                                        |
| time    | 记录重要的日子，时间、时刻 | 记录日期或是具体时间的时间戳                                 |
| encrypt | words 是否进行加密存储     | true(加密)/false(未加密) ，前端对 words 内容选择性进行加密（AES/RSA等等） |

**结构**

```
Starcoin Account
|
|_____ Resource
         |
         |_____ Memories
```



方案二：将重要信息存储到区块的 Transaction 中。例如通过转账将重要信息记录上链。



**对比**

方案一，将自己的账户存储资源当做一个数据库了，便于自由管理。

方案二，记录的信息上链，防篡改。

根据需求分析，我们选择**方案一**进行实现。



### 代码

#### 结构体

**Memory**

```move
struct Memory has copy,store,drop {
    id: u64,
    words: vector<u8>,
    time: u64,
    encrypt: bool,
}
```

**Memories**

```move
struct Memories has key,drop {
	value: vector<Memory>,
}
```

#### 普通函数

**初始化 Memories 资源**

```move
public fun init(account: &signer) {
	move_to(account, Memories { value: Vector::empty<Memory>() });
} 
```

**向 Memories 资源中添加一个 Memory**

```move
public fun insert(account: &signer,newMemory: Memory) acquires Memories{
	let memories = borrow_global_mut<Memories>(Signer::address_of(account));
	Vector::push_back<Memory>(&mut memories.value,newMemory);
}
```

**移除 Memories 中的某一个 Memory**

```move
public fun delete(account: &signer, memory:Memory) acquires Memories {
	let memoriesRes = borrow_global_mut<Memories>(Signer::address_of(account));
	let memories = &mut memoriesRes.value;
	let (res,idx) = Vector::index_of(memories, &memory);
	if(res) {
		Vector::remove<Memory>(memories,idx);
		*memoriesRes = Memories { value: *memories }
	}
}
```

#### 脚本函数

**创建入口**

```move
public (script) fun create(account: signer, words:vector<u8>, time:u64, encrypt:bool) acquires Memories {
	if(!exists<Memories>(Signer::address_of(&account))) {
		Self::init(&account);
	};
	Self::insert(&account,Memory {
		id: Timestamp::now_milliseconds(),
		words,
		time,
		encrypt,
	});
}
```

**删除入口**

```move
public (script) fun remove(account: signer, id:u64, words:vector<u8>, time:u64, encrypt:bool) acquires Memories {
	Self::delete(&account, Memory {
		id,
		words,
		time,
		encrypt,
	});
}
```

**清空资源入口**

```move
public (script) fun destroy(account: signer) acquires Memories {
	move_from<Memories>(Signer::address_of(&account));
}
```



### 构建

```bash
mpm package build

mpm release
```



### 部署 

**解锁操作账户**

```bash
account unlock 0x5e946f0d254240346f19e518d78d5390
```



**执行部署命令**

```bash
dev deploy /home/cs18/dev/move_ws/memories/release/memories.v0.0.0.blob -s 0x5e946f0d254240346f19e518d78d5390 -b
```



### 功能脚本

**创建**

1.创建一个 Memory 存入账户下

```bash
account execute-function --function 0x5e946f0d254240346f19e518d78d5390::Memories::create --arg x"e4bda0e5a5bd6d6f7665" --arg 1664812800000u64 --arg false -s 0x5e946f0d254240346f19e518d78d5390 -b
```



 2.再创建一个 Memory

```bash
account execute-function --function 0x5e946f0d254240346f19e518d78d5390::Memories::create --arg x"68656c6c6f2c6d6f7665" --arg 1664895691000u64 --arg true -s 0x5e946f0d254240346f19e518d78d5390 -b
```



3.查看账户下的资源

```bash
state list resource 0x5e946f0d254240346f19e518d78d5390
```



**删除**

删除某一个 Memory

```bash
account execute-function --function 0x5e946f0d254240346f19e518d78d5390::Memories::remove --arg 148478u64 --arg x"68656c6c6f2c6d6f7665" --arg 1664895691000u64 --arg true -s 0x5e946f0d254240346f19e518d78d5390 -b
```



**移除资源**

移除账户下的 Memories

```bash
account execute-function --function 0x5e946f0d254240346f19e518d78d5390::Memories::destroy -s 0x5e946f0d254240346f19e518d78d5390 -b
```



### UI

TODO 

前端交互端暂未实现。