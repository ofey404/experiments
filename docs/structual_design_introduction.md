# 架构设计入门知识


这两篇文章非常好：

- [架构设计入门知识 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/153030979)
- [架构设计的大忌：我没错 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/156664216)



是面对一片空白画布，添加约束的过程。

- 开发的过程是逐步细化。
- 架构的作用就是，降低细节的难度。
  - 否则不如直接设计细节。
- 需要对细节的预判。



我现在做不到预判这个系统的细节。能通过调研改善吗？

- 现在这个系统，是比较标准化的系统（一个 service），有很多前人的经验。
- 需要找到这些经验。



“形而上的设计”，就是要在当前抽象层看到结果，不能引用细节来淹没对方，假装证明自己是对的。



4 + 1 视图，之前看过，这次试一下？

- 逻辑视图。关注边界。eg 写个用户手册。
- 开发视图。部件如何分解？开发和维护如何组织？维护、升级、组合的时候是否可以互相匹配？
- 处理视图。业务逻辑，哪些逻辑需要串行，哪些可以并行？哪部分放到什么节点上？
- 部署视图。软件如何分布在硬件上。



除了根本约束，其他的约束都是自己引入的。

- 我们的根本约束，完成以下业务流程：
  - 用户 => 数据库 => 计算节点 => 用户



[推荐一本学习架构设计的书 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/163336687)

- [5G System Design: Architectural and Functional Considerations and Long Term Research | Wiley](https://www.wiley.com/en-us/5G+System+Design%3A+Architectural+and+Functional+Considerations+and+Long+Term+Research-p-9781119425120)



## 技术选型的艺术

[技术选型的艺术 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/36619380)


## 绘图

图的种类：

- ER 图
- 上下文图
- 过程模型
- 数据流图



[如何画好数据流图？ - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/231863024)

- 自顶向下多层。
- Yourdon & De Marco Style；



[A Beginner's Guide to Data Flow Diagrams (hubspot.com)](https://blog.hubspot.com/marketing/data-flow-diagram)

![Data-flow-diagram-symbols](https://lh6.googleusercontent.com/NnLNAMluc7B7Cqpic3yuoiwAHqrwNM8Hi5nGiSOI6J3sC_BkcQmVx42KZghjxeqy5lFSIFW8MJLEshrmYvYdxc3E7Jwyyi2yQnpyFgls4l3gH_fCEksTvQC94GtzstgEgOApr6aK)
