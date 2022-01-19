# fe集群模式注意事项
第一次启动fe一定要用–helper启动，否则启动不成功，无法加入集群，必须借助已经启动的FE节点（master或者follower）来扩容新的节点,helper 不能指向 新FE节点 自身
当新的fe第一次启动失败，或无法加入集群时。修改配置后，一定要先清空fe的meta路径，然后再重启fe（[参考](https://blog.csdn.net/qq_23329167/article/details/114280537)）


# doris集群多网卡问题
doris 在K8s多网卡环境中 priority_networks 网络问题修复
因为有多网卡的存在，或因为安装过 docker 等环境导致的虚拟网卡的存在，同一个主机可能存在多个不同的 ip。
当前 Doris 并不能自动识别可用 IP。所以当遇到部署主机上有多个 IP 时，必须通过 priority_networks 配置项来强制指定正确的 IP。
否则doris会随机去绑定一个ip，在k8s多网卡环境下服务重启就会出问题。

在K8s多网卡等容器化编排环境中因为有多网卡的存在，通过固定IP的形式部署Doris集群，同一个主机可能存在多个不同的 ip。
当前Doris实例并不能自动识别可用 IP。所以当遇到部署主机上有多个IP时，必须通过优先网络（priority_networks）来强制指定正确的 IP（即容器编排是传入的IP地址）。
否则doris实例会随机去绑定一个ip，这样以来在当前Doris实例故障恢复时就不能再与当前Doris集群建立连接。