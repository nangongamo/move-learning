## Move 开发环境配置

**执行`dev_setup.sh`脚本遇到的问题记录。**

> 首先在 Windows 上没能如愿，就没去折腾了，换 Ubuntu 系统上操作了，也遇到了些问题，记录如下。

### Ubuntu

#### Q1:

普通用户执行`./script/dev_setup.sh`时会报权限错误，因此会加上 sudo 命令（`sudo ./script/dev_setup.sh` -ypt），因此又会出现另外一个问题，如下所示的错误：

```bash
./script/dev_setup.sh：line 155：mpm：command not found
```

`mpm`明明已经配置好了环境变量，执行`mpm --version`也正常，但执行`sudo mpm --version`时会报错：

```bash
sudo：mpm：command not found
```

**原因：**

Linux 系统中在使用 sudo 执行命令时是为当前用户赋予临时的 root 权限，考虑到安全性等相关问题，**sudo 执行命令时会重置 PATH**，此时 PATH 中是不包含用户配置的很多命令的路径的。所以会发现 sudo 执行命令时可能存在找不到的情况。

**解决方案：**

使用 `sudo vim /etc/sudoers` 进行修改，找到 secure_path 这一行，在其中追加 mpm的路径即可（和配置环境变量的 mpm 路径一致，也是用`:`追加），然后通过 :wq! 保存即可。

此后，你再执行`sudo mpm`相关命令时，提示找不到的错误就不会出现了。

#### Q2:

在更新包依赖的时候，`apt-get` 运行报错，无法获得锁。

```bash
Reading package lists... Done
Installing ca-certificates......
Installing ca-certificates.
E: Could not get lock /var/lib/dpkg/lock-frontend - open (11: Resource temporarily unavailable)
E: Unable to acquire the dpkg frontend lock (/var/lib/dpkg/lock-frontend), is another process using it?
```

**解决方案：**

先查看是否有 apt-get 这个程序在运行

```bash
ps aux|grep apt-get
```

如果发现存在这样的程序在运行那么就 kill 掉，否则执行如下命令(直接删除锁文件)

```bash
sudo rm /var/lib/dpkg/lock-frontend
sudo rm /var/lib/dpkg/lock
sudo rm /var/cache/apt/archives/lock
```

#### Q3:

`Debian Packager`的问题，dpkg 安装被中断。

```bash
E: dpkg was interrupted, you must manually run 'sudo dpkg --configure -a' to correct the problem. 
```

**解决办法：**

执行如下命令

``` bash
sudo dpkg --configure -a 
```

然后，再执行如下命令：

```bash
sudo apt-get update 
sudo apt-get upgrade
```

如果上述操作依然不行的话，直接删除重新更新。即：

```bash
sudo rm /var/lib/dpkg/updates/* 
sudo apt-get update 
sudo apt-get upgrade
```

保守的操作的话，可以选择如下操作：

```bash
sudo mv /var/lib/dpkg/info/ /var/lib/dpkg/info_old/
sudo mkdir /var/lib/dpkg/info/
sudo apt-get update

sudo apt-get -f install
   
sudo mv /var/lib/dpkg/info/* /var/lib/dpkg/info_old/
sudo rm -rf /var/lib/dpkg/info
sudo mv /var/lib/dpkg/info_old/ /var/lib/dpkg/info/
```

#### Q4:

`dev_setup.sh` 脚本执行成功后，但执行`boogie /version` 提示命令未找到。

```bash
.......Installation finished successfully.
Installing boogie
You can invoke the tool using the following command: boogie
Tool 'boogie' (version '2.9.6') was successfully installed.
Finished installing all dependencies.

You should now be able to build the project by running:
	mpm package build
	mpm package prove
```

```bash
starcoin$ boogie /version
Command 'boogie' not found, but can be installed with:

sudo apt install boogie
```

**原因：**

环境变量配置未生效。

**解决办法：**

执行如下命令即可：

```bash
source ~/.profile
```




