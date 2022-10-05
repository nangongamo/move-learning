# Docker 使用的基本命令

```bash
#查找镜像
docker search IMAGE
#拉取镜像
docker pull IMAGE
#推送镜像到registry
docker push IMAGE
#查看Docker版本
docker version
#查看当前在运行的容器
docker ps
#查看所有被创建的容器（运行中的或停止的）
docker ps -a
#查看镜像和容器的详细信息（容器ID或镜像）
docker inspect CID/IMAGE
#查询容器的full Id
docker inspect -f '{{.Id}}' CID
#列出所有的镜像
docker images


#只创建容器但不启动
docker create --name CONTAINER_Name imageName
#启动指定容器（启动一个已存在的容器, 和run创建容器不一样）
docker start CID
#停止指定容器
docker stop CID
#重启指定容器
docker restart CID
#停止容器
docker pause Name/ID
#恢复容器
docker unpause Name/ID
#从IMAGE创建一个容器；如果本地没有镜像就从共有库下载，
#-i-t交互模式，--name容器名字, 登录的shell是/bin/bash
docker run -it --name MYCONTAINER IMAGE/IMAGE_ID /bin/bash
#运行出一个container放到后台运行
docker run -d hello-world	
#运行最后一次的版本
docker run --name latest --net=host -it NAME /bin/bash	
#映射host到container的端口和目录
#默认，绑定主机所有网卡（0.0.0.0）的80端口到容器的80端口上。
#-p 80:80
#只绑定localhost这个接口的80的接口
#-p 127.0.0.1:80:80

#将container固化成一个新image, 保存之前的修改，只能提交正在运行的container（docker ps）
docker commit <container> [repo:tag]

#进行一个运行中的容器，开启一个新的终端
docker exec -it CONTAINER_ID /bin/bash



#连接到正在部署的容器, 确保CTRL-D或CTRL-C不会关闭容器
docker attach --sig-proxy=false
docker rm CID/IMAGE 
#删除所有停止的容器
docker rm $(docker ps -a -q)
docker rmi <image_id/image_name ...>

#查看容器的日志输出
docker logs CONTAINER_Name
#阻塞运行直到容器停止，然后打印出它的退出代码
docker wait CONTAINER_Name
#将容器进行打包保存到本地，文件类型为tar
docker export -o test.tar CONTAINER_ID 
#将上面保存的文件导入到镜像库中
cat test.tar |docker import - image_name:tag
#查看容器的端口映射情况
docker port CONTAINER_ID

```