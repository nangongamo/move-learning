

# 运行本地Dev网络



## 熟悉 Docker

**Docker** 官网：https://www.docker.com/

我下载的是 `Windows Docker Desktop` 初次体验下。

学习 Docker 相关命令。总结见：[docker-basic.md](./docker-basic.md)



## 获取 Starcoin Docker 镜像

```bash
docker pull starcoin/starcoin:latest
```



## 运行 Starcoin 本地Dev网络

执行如下命令，运行 starcoin 本地开发网络

```bash
docker run -d --name starcoin-dev -p 9850:9850 -p 9860:9860 -p 9870:9870 -v /e/docker_v/starcoin/:/root/.starcoin/ starcoin/starcoin:latest /starcoin/starcoin -n dev
```



说明：

`-d`  后台启动。

`--name`  容器名称。

`-p`  宿主机端口与容器端口映射。

`-v` 数据卷挂载。宿主机目录与容器目录映射，冒号`：`左侧的路径代表是`宿主机`的相关目录，右侧是Docker`容器`里面的目录。

​	  我这里宿主机是windows操作系统，这里目录的写法是这样的，`E:/docker_v/starcoin/` 写成 `/e/docker_v/starcoin`

-n 指定网络，例如 `/starcoin/starcoin -n dev` 就是指开发`dev`环境启动 starcoin。



> 注：这行命令比较长，可以使用`续行符` 在Linux系统中是用`\`表示，Windows系统是用`^`表示，即：



**换行示例：**

**Linux**

```bash
docker run -d --name starcoin-dev \
-p 9850:9850 \
-p 9860:9860 \
-p 9870:9870 \
-v /e/docker_v/starcoin/:/root/.starcoin/ \
starcoin/starcoin:latest \
/starcoin/starcoin -n dev
```

**Windows**

```bash
docker run -d --name starcoin-dev ^
-p 9850:9850 ^
-p 9860:9860 ^
-p 9870:9870 ^
-v /e/docker_v/starcoin/:/root/.starcoin/ ^
starcoin/starcoin:latest ^
/starcoin/starcoin -n dev
```



**节点启动成功日志：**

```
2022-08-26T06:05:30.637719500+00:00 INFO - Starcoin opts: {"net":"dev","rpc":{"http":{},"tcp":{},"ws":{},"ipc":{},"api_quotas":{}},"logger":{},"metrics":{"push_config":{"interval":5}},"miner":{},"network":{"network_rpc_quotas":{}},"txpool":{},"storage":{},"sync":{},"vault":{},"stratum":{},"account_provider":{"from_env":false}}
2022-08-26T06:05:30.637765500+00:00 INFO - Start starcoin node...
2022-08-26T06:05:30.643600800+00:00 INFO - Config file not exist, generate default config to: "/root/.starcoin/dev/config.toml"
2022-08-26T06:05:30.646466900+00:00 INFO - Http rpc address: Some(http://0.0.0.0:9850)
2022-08-26T06:05:30.646499100+00:00 INFO - TCP rpc address: Some(tcp://0.0.0.0:9860)
2022-08-26T06:05:30.646506100+00:00 INFO - Websocket rpc address: Some(ws://0.0.0.0:9870)
2022-08-26T06:05:30.646511700+00:00 INFO - Ipc file path: "/root/.starcoin/dev/starcoin.ipc"
2022-08-26T06:05:30.646560200+00:00 INFO - Stratum listen address: None, port:None
2022-08-26T06:05:30.648998100+00:00 INFO - Final config: {"network":{"node_name":"calm-visitor-6004","network_rpc_quotas":{}},"rpc":{"http":{},"tcp":{},"ws":{},"ipc":{},"api_quotas":{}},"miner":{},"storage":{},"tx_pool":{},"sync":{},"vault":{},"metrics":{"push_config":{"interval":0}},"logger":{},"stratum":{},"account_provider":{"from_env":false}}
2022-08-26T06:05:30.650281600+00:00 INFO - Final data-dir is : "/root/.starcoin/dev"
2022-08-26T06:05:30.650310600+00:00 INFO - Write log to file: "/root/.starcoin/dev/starcoin.log"
2022-08-26T06:05:30.654943900+00:00 INFO - Registry service: starcoin_service_registry::bus::service::BusService
2022-08-26T06:05:30.655354400+00:00 INFO - Service starcoin_service_registry::service_registry::RegistryService start.
2022-08-26T06:05:30.655404500+00:00 INFO - Service starcoin_service_registry::bus::service::BusService start.
2022-08-26T06:05:30.655569900+00:00 INFO - starcoin_service_registry::service_registry::RegistryService service actor started
2022-08-26T06:05:30.655740+00:00 INFO - starcoin_service_registry::bus::service::BusService service actor started
2022-08-26T06:05:30.655897600+00:00 INFO - Put shared by type: alloc::sync::Arc<starcoin_config::NodeConfig>
2022-08-26T06:05:30.656786300+00:00 INFO - Put shared by type: alloc::sync::Arc<starcoin_logger::LoggerHandle>
2022-08-26T06:05:30.657047600+00:00 INFO - Put shared by type: starcoin_vm_runtime::metrics::VMMetrics
2022-08-26T06:05:30.657328700+00:00 INFO - rocksdb max open files 40960
2022-08-26T06:05:31.853353700+00:00 INFO - Upgrade db from V1 to V3
2022-08-26T06:05:32.069047900+00:00 INFO - remove unused column block_body, column transaction_info
2022-08-26T06:05:32.092206+00:00 INFO - Put shared by type: alloc::sync::Arc<starcoin_storage::Storage>
2022-08-26T06:05:32.420332+00:00 INFO - [starcoin-vm] Executed txn: HashValue(0x39a0bb95283f17470a202aba4e0db499d6efe8ecbe3d778d1e2e05df5199a792) (sender: 0x00000000000000000000000000000001, sequence_number: 0) txn_status: Keep(EXECUTED), gas_used: 0, vm_status: Executed
2022-08-26T06:05:32.430486900+00:00 INFO - Build and save new genesis: Genesis {block: HashValue(0x8a08da50fa9edae7d4e880a877bb04f1f94a947f9dc98d688c5ce76b2049ac92); parent_hash: HashValue(0x3a9c4141b1893c28c96eda9dd937145fe3cee63c0160b91a391b9afe789c5fd5); timestamp: 0; accumulator_root: HashValue(0x281cbf84f569a102ddd200f912cd878893a21d1cd3cc2aedf2de0ce27e9294da); state_root: HashValue(0xc38357ab11024afe82439edaff7cfdbbf4341a0daee5959a17068c6255b42034); difficulty: 1; body_hash: HashValue(0x11d0a21a5d0036dd7e878c36f99036c9228e35124449311b7370e19ded07c196); chain_id: ChainId { id: 254 }; }

......

2022-08-26T06:05:34.644466100+00:00 INFO - Registry service: starcoin_stratum::service::StratumService
2022-08-26T06:05:34.645179700+00:00 INFO - Service starcoin_rpc_server::module::pubsub::PubSubService start.
2022-08-26T06:05:34.645240400+00:00 INFO - Registry service: starcoin_node::metrics::MetricsServerActorService
2022-08-26T06:05:34.645591300+00:00 INFO - starcoin_rpc_server::module::pubsub::PubSubService service actor started
2022-08-26T06:05:34.646497100+00:00 INFO - Service starcoin_node::metrics::MetricsServerActorService start.
2022-08-26T06:05:34.646707200+00:00 INFO - starcoin_node::metrics::MetricsServerActorService service actor started
2022-08-26T06:05:34.646759+00:00 INFO - Service starcoin_stratum::service::StratumService start.
2022-08-26T06:05:34.646957600+00:00 INFO - Metric server start at: 0.0.0.0:9101
2022-08-26T06:05:34.647100500+00:00 INFO - starcoin_stratum::service::StratumService service actor started
2022-08-26T06:05:34.647622500+00:00 INFO - Metric server started at 0.0.0.0:9101
2022-08-26T06:05:34.647918400+00:00 INFO - Ipc rpc server start at :"/root/.starcoin/dev/starcoin.ipc"
2022-08-26T06:05:34.648150600+00:00 INFO - Connect by in process channel
2022-08-26T06:05:34.651678500+00:00 INFO - Rpc: http server start at :0.0.0.0:9850
2022-08-26T06:05:34.652016100+00:00 INFO - Rpc: tcp server start at: 0.0.0.0:9860
2022-08-26T06:05:34.697687600+00:00 INFO - Listening for new connections on 0.0.0.0:9870.
2022-08-26T06:05:34.698269100+00:00 INFO - Rpc: websocket server start at: 0.0.0.0:9870
2022-08-26T06:05:34.698660700+00:00 INFO - Service starcoin_rpc_server::service::RpcService start.
2022-08-26T06:05:34.699063900+00:00 INFO - starcoin_rpc_server::service::RpcService service actor started
2022-08-26T06:05:34.715460400+00:00 INFO - Receive event to stop ChainWatcher.

```



## 控制台交互

### 进入容器

```bash
docker exec -it starcoin-dev /bin/bash
```

> 参数 `-it` 后可以是容器ID或者是容器名称。 

首次启动时，查看日志找到`Ipc file path`，参考如下日志，于是我们找到了ipc文件的路径`/root/.starcoin/dev/starcoin.ipc`

```
2022-08-26T06:05:30.637765500+00:00 INFO - Start starcoin node...
2022-08-26T06:05:30.643600800+00:00 INFO - Config file not exist, generate default config to: "/root/.starcoin/dev/config.toml"
2022-08-26T06:05:30.646466900+00:00 INFO - Http rpc address: Some(http://0.0.0.0:9850)
2022-08-26T06:05:30.646499100+00:00 INFO - TCP rpc address: Some(tcp://0.0.0.0:9860)
2022-08-26T06:05:30.646506100+00:00 INFO - Websocket rpc address: Some(ws://0.0.0.0:9870)
2022-08-26T06:05:30.646511700+00:00 INFO - Ipc file path: "/root/.starcoin/dev/starcoin.ipc"
2022-08-26T06:05:30.646560200+00:00 INFO - Stratum listen address: None, port:None
```

### 进入 starcoin console

执行如下命令：

```bash
/starcoin/starcoin -c /root/.starcoin/dev/starcoin.ipc console
```

`-c` ： 是指 connect ，应该是指连接节点的方式吧。

> -c, --connect <CONNECT>
>             Connect and attach to a node



出现如下界面，表示成功了：

```
                                                      ::::::::███████::
                                                :::::███████████████████:
                                  :█████████:  :████████:::        :██████
                                  █████:█████:  █::                  █████:
                                 █████: :█████:                     :█████
                                :█████   :████:                    :█████:
                               :█████:    :████:                  :█████:
                              :█████:      █████:               :██████
               :███████████████████:       :███████████████:   ██████:
              :████████████████████         :████████████:   :█████:
              █████:                                      :██████:
             ::███████::                                :██████:
          :█::  ::████████:                          :███████:
        :████:::    :████████:                    ::██████:
      :█████::         ::█████:                  :█████::
    :██████:            :████:                   :█████:
   :█████:             :█████           :         :█████:
  :████:              :█████:        :█████::      :█████:
 :████:              :█████:     :█████████████:    :█████
:█████               █████: :██████████: :████████:  :████:
:████:               :████████████::        ::████████████:
 :█████::::::::::::██   ::███::                 :██████:
  :█████████████████::
      :::█████::::

         ██████╗████████╗  ███╗  ██████╗  █████╗  █████╗ ██╗███╗  ██╗
        ██╔════╝╚══██╔══╝ ██ ██╗ ╚════██╗██╔══██╗██╔══██╗██║████╗ ██║
        ╚█████╗    ██║   ██   ██║██████╔╝██║  ╚═╝██║  ██║██║██╔██╗██║
         ╚═══██╗   ██║   ██╔══██║██╔══██╗██║  ██╗██║  ██║██║██║╚████║
        ██████╔╝   ██║   ██║  ██║██║  ██║╚█████╔╝╚█████╔╝██║██║ ╚███║
        ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝  ╚════╝ ╚═╝╚═╝  ╚══╝
starcoin%
```



**console**是啥？

starcoin的交互式控制台，命令操作都是在这个下面进行的。



`/root/.starcoin/dev/starcoin.ipc`

这个 **IPC** 文件是个啥？？

**进程间通信**（英语：**Inter-Process Communication**，简称**IPC**），指至少两个进程或线程间传送数据或信号的一些技术或方法。

>来自TG用户`Joe Chen`解答：
>
>ipc是进程间通信文件，只要你启动有节点，这个文件就会存在，退出之后就会消失。
>
>比如，一个节点启动后，想在另一个窗口使用 Starcoin 控制台来操作一些内容，就可以使用ipc来接入（attach）



维基百科：[进程间通信](https://zh.wikipedia.org/wiki/%E8%A1%8C%E7%A8%8B%E9%96%93%E9%80%9A%E8%A8%8A)



## 熟悉starcoin 账户

### 概念

#### 账户

账户代表了 Starcoin 上的一个可以发送交易的资源。一个账户是一组Move 资源的集合。其由16 字节的地址唯一标识。

#### 认证密钥

认证密钥（authentication_key），每个账户都会在链上存储了一个认证密钥，用于认证交易的签名。

#### 地址

一个账户的地址来自于它的初始认证密钥。Starcoin 支持在不改变其地址的情况下修改账户的认证密钥。

#### 收款识别码

一种编码后的地址，包含的校验机制，避免复制的时候被篡改。



**账户模型解说：**https://starcoin.org/zh/developers/others/starcoin_contract_account/



### 体验账户

**查看默认账户**

`account default`

```
starcoin% account default
{
  "ok": {
    "address": "0x8e53fdac54518d9a5c8a81d42457f347",
    "is_default": true,
    "is_readonly": false,
    "public_key": "0x710e1fae36d09d2f055d19fe0c380311346179117a2780db2a8e1c40dff6a51b",
    "receipt_identifier": "stc1p3eflmtz52xxe5hy2s82zg4lngu9hyvsu"
  }
}
```

> 默认账户有个属性，is_default = true
>
> Starcoin 节点内置了一个去中心化的钱包，用户可以通过账号相关的接口以及命令来管理自己的账户。节点启动的时候，会自动创建一个默认账户，默认密码为空。 默认账户可以通过账户相关的命令进行变更。



**创建账户**

`account create -p <MY-PASSWORD>`

```bash
starcoin% account create -p 123456
{
  "ok": {
    "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "is_default": false,
    "is_readonly": false,
    "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
    "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
  }
}
```





**查看指定账户**

`account show <ACCOUNT_ADDRESS>`

```bash
starcoin% account show 0xf518d7e9e35576fa4fd6711af7e1a834
{
  "ok": {
    "account": {
      "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
      "is_default": false,
      "is_readonly": false,
      "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
      "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
    },
    "auth_key": "0x4cfda93054b241561b9460ca47c0b302f518d7e9e35576fa4fd6711af7e1a834",
    "balances": {},
    "sequence_number": null
  }
}
```



**查看所有账户**

`account list`

> 这个命令会列出当前节点上的所有账户。

```bash
starcoin% account list
{
  "ok": [
    {
      "address": "0x8e53fdac54518d9a5c8a81d42457f347",
      "is_default": true,
      "is_readonly": false,
      "public_key": "0x710e1fae36d09d2f055d19fe0c380311346179117a2780db2a8e1c40dff6a51b",
      "receipt_identifier": "stc1p3eflmtz52xxe5hy2s82zg4lngu9hyvsu"
    },
    {
      "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
      "is_default": false,
      "is_readonly": false,
      "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
      "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
    }
  ]
}
```



**变更默认账号**

`account default <ACCOUNT_ADDRESS>`

```bash
starcoin% account default 0xf518d7e9e35576fa4fd6711af7e1a834
{
  "ok": {
    "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "is_default": true,
    "is_readonly": false,
    "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
    "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
  }
}
```



**导出账号**

`account export <ACCOUNT_ADDRESS> -p <MY-PASSWORD>`

```bash
starcoin% account export 0xf518d7e9e35576fa4fd6711af7e1a834 -p 123456
{
  "ok": {
    "account": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "private_key": "0x48b259e608562d169af69736564c0c0165257cea0679c22581e4023c0ef2b35f"
  }
}
```



**删除账号**

`account remove <ACCOUNT_ADDRESS> -p <MY-PASSWORD>`

```bash
starcoin% account remove 0xf518d7e9e35576fa4fd6711af7e1a834 -p 123456
{
  "err": "Server returned rpc error Invalid params: cannot remove default account 0xf518d7e9e35576fa4fd6711af7e1a834"
}
```

> 不能删除默认账户，会报错。
>
> 这里我更换了默认账户为其他，然后可以删除了。

```bash
starcoin% account remove 0xf518d7e9e35576fa4fd6711af7e1a834 -p 123456
{
  "ok": {
    "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "is_default": false,
    "is_readonly": false,
    "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
    "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
  }
}
```

> 可以 `account list` 验证下。



**导入账号**

`account import -i <PRIVATE-KEY> -p <MY-PASSWORD> <ACCOUNT_ADDRESS>`

```bash
starcoin% account import -i 0x48b259e608562d169af69736564c0c0165257cea0679c22581e4023c0ef2b35f -p 123456 0xf518d7e9e3557
6fa4fd6711af7e1a834
{
  "ok": {
    "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "is_default": false,
    "is_readonly": false,
    "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
    "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
  }
}
```

> 如果不想把私钥托管在节点钱包中，只是想查看该账号，或者将该账号作为挖矿账号，可以通过公钥导入只读账号。然后将该账号设置为默认账号。

**导入账户只读**

`account import-readonly -i <PUBLIC-KEY>`



**锁定账户**

`account lock <ACCOUNT_ADDRESS>`

```
starcoin% account lock 0xf518d7e9e35576fa4fd6711af7e1a834
{
  "ok": {
    "result": "0xf518d7e9e35576fa4fd6711af7e1a834"
  }
}
```

**解锁账户**

`account unlock <ACCOUNT_ADDRESS> -p <MY-PASSWORD> -d <SECOND>`

>`-d` 选项可以指定账户保持解锁的时间（单位为秒），默认值为 `300` 秒。

```
starcoin% account unlock 0xf518d7e9e35576fa4fd6711af7e1a834  -p 123456 -d 300
{
  "ok": {
    "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
    "is_default": false,
    "is_readonly": false,
    "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
    "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
  }
}
```



### 体验交易

在本地开发环境，可以通过如下命令获取`STC`进行测试。

`dev get-coin -v 1000STC`

> Dev 环境下，可以利用 faucet 给账户充钱。Faucet 只在 `dev` 和 `test` 网络中存在，以便于开发者做开发和测试。 
>
> `dev get-coin` 会往默认账户中充钱，如果链上不存在这个账户，它会先创建这个账户，然后再往该账户转入 `-v` 指定数量的 coin。 命令输出的是由 faucet 账户（地址是 `0000000000000000000000000a550c18`）发出的交易信息。

查看下账户余额：

```bash
starcoin% account show 0xdb206a8dd7b91ec54593d66902698e70
{
  "ok": {
    "account": {
      "address": "0xdb206a8dd7b91ec54593d66902698e70",
      "is_default": true,
      "is_readonly": false,
      "public_key": "0xaade5808cafd54593e4481453cf5e187fb03ef80814dcd7a0a97d4361b133dfc",
      "receipt_identifier": "stc1pmvsx4rwhhy0v23vn6e5sy6vwwqazhnre"
    },
    "auth_key": "0x4c7f4990c5ca5f672a052ab649e93692db206a8dd7b91ec54593d66902698e70",
    "balances": {
      "0x00000000000000000000000000000001::STC::STC": 1000000000000
    },
    "sequence_number": 0
  }
}
```



**体验转账**

例如从`0xdb206a8dd7b91ec54593d66902698e70`账户转**100STC** 到 `0xf518d7e9e35576fa4fd6711af7e1a834`账户。

**转账命令如下：**

`account transfer -s <SENDER> -r <RECEIVER> -v <AMOUNT> -b`

`-s` 是指 sender，发送者地址；

`-r` 是指 receiver，接收者地址；

`-v` 是指 amount，转账数量( STC 的精度是9位)；

`-b` 表示阻塞等待区块(交易)打包；

发送者账户需先解锁，才能进行转账操作，不然会报错。如下所示：

```bash
{
  "err": "Server returned rpc error Invalid params: account 0xdb206a8dd7b91ec54593d66902698e70 is locked"
}
```

**先解锁再转账**

```bash
starcoin% account unlock 0xdb206a8dd7b91ec54593d66902698e70 -p 123456 -d 300
{
  "ok": {
    "address": "0xdb206a8dd7b91ec54593d66902698e70",
    "is_default": true,
    "is_readonly": false,
    "public_key": "0xaade5808cafd54593e4481453cf5e187fb03ef80814dcd7a0a97d4361b133dfc",
    "receipt_identifier": "stc1pmvsx4rwhhy0v23vn6e5sy6vwwqazhnre"
  }
}
starcoin% account transfer -s 0xdb206a8dd7b91ec54593d66902698e70 -r 0xf518d7e9e35576fa4fd6711af7e1a834 -v 100000000000 -b

```

验证下`0xf518d7e9e35576fa4fd6711af7e1a834`余额，看是否收到。

```
starcoin% account show 0xf518d7e9e35576fa4fd6711af7e1a834
{
  "ok": {
    "account": {
      "address": "0xf518d7e9e35576fa4fd6711af7e1a834",
      "is_default": false,
      "is_readonly": false,
      "public_key": "0xc644d5a1d5def8971aa2f57e66f3379c455ae32634550e5cc194e4837b2f66d4",
      "receipt_identifier": "stc1p75vd060r24m05n7kwyd00cdgxshe8rzj"
    },
    "auth_key": "0x4cfda93054b241561b9460ca47c0b302f518d7e9e35576fa4fd6711af7e1a834",
    "balances": {
      "0x00000000000000000000000000000001::STC::STC": 100000000000
    },
    "sequence_number": 0
  }
}
```

确实，收到100STC。



**account transfer** 详细参数解释见如下：

```bash
starcoin% account transfer -h
account-transfer
Transfer token's command, this command will send a transaction to the chain

USAGE:
    account transfer [OPTIONS] --receiver <RECEIVER> -v <AMOUNT>

OPTIONS:
    -b, --blocking
            blocking wait transaction(txn) mined

        --dry-run
            dry-run mode, only get transaction output, do not change chain state

        --expiration-time-secs <expiration-time-secs>
            how long(in seconds) the txn stay alive from now

        --gas-unit-price <price of gas unit>
            gas price used to deploy the module

    -h, --help
            Print help information

    -k, --public-key <public-key>
            this option is deprecated

        --max-gas-amount <MAX_GAS_AMOUNT>
            max gas used to deploy the module

    -r, --receiver <RECEIVER>
            transfer to, accept address (start with 0x) or receipt_identifier (start with stc)

    -s, --sender <SENDER>
            the account address for signing transaction, if `sender` is absent, use default account

        --sequence-number <SEQUENCE_NUMBER>
            transaction's sequence_number if a transaction in the pool, you want to replace it, can
            use this option to set transaction's sequence_number otherwise please let cli to auto
            get sequence_number from onchain and txpool

    -t, --token-code <token-code>
            token's code to transfer, for example: 0x1::STC::STC, default is STC.

    -v <AMOUNT>


```

