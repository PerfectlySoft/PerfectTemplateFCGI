# PerfectTemplateFCGI [English](README.zh_CN.md)

<p align="center">
    <a href="http://perfect.org/get-involved.html" target="_blank">
        <img src="http://perfect.org/assets/github/perfect_github_2_0_0.jpg" alt="Get Involed with Perfect!" width="854" />
    </a>
</p>

<p align="center">
    <a href="https://github.com/PerfectlySoft/Perfect" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_1_Star.jpg" alt="Star Perfect On Github" />
    </a>  
    <a href="http://stackoverflow.com/questions/tagged/perfect" target="_blank">
        <img src="http://www.perfect.org/github/perfect_gh_button_2_SO.jpg" alt="Stack Overflow" />
    </a>  
    <a href="https://twitter.com/perfectlysoft" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_3_twit.jpg" alt="Follow Perfect on Twitter" />
    </a>  
    <a href="http://perfect.ly" target="_blank">
        <img src="http://www.perfect.org/github/Perfect_GH_button_4_slack.jpg" alt="Join the Perfect Slack" />
    </a>
</p>

<p align="center">
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Swift-3.0-orange.svg?style=flat" alt="Swift 3.0">
    </a>
    <a href="https://developer.apple.com/swift/" target="_blank">
        <img src="https://img.shields.io/badge/Platforms-OS%20X%20%7C%20Linux%20-lightgray.svg?style=flat" alt="Platforms OS X | Linux">
    </a>
    <a href="http://perfect.org/licensing.html" target="_blank">
        <img src="https://img.shields.io/badge/License-Apache-lightgrey.svg?style=flat" alt="License Apache">
    </a>
    <a href="http://twitter.com/PerfectlySoft" target="_blank">
        <img src="https://img.shields.io/badge/Twitter-@PerfectlySoft-blue.svg?style=flat" alt="PerfectlySoft Twitter">
    </a>
    <a href="http://perfect.ly" target="_blank">
        <img src="http://perfect.ly/badge.svg" alt="Slack Status">
    </a>
</p>

Perfect 软件框架 FastCGI 空白项目模板

本项目包括了一个空白的HTTP服务器，采用SPM软件包管理器编译，编译后能够生成一个基于 FastCGI 的可执行服务器。

## 问题报告、内容贡献和客户支持

我们目前正在过渡到使用JIRA来处理所有源代码资源合并申请、修复漏洞以及其它有关问题。因此，GitHub 的“issues”问题报告功能已经被禁用了。

如果您发现了问题，或者希望为改进本文提供意见和建议，[请在这里指出](http://jira.perfect.org:8080/servicedesk/customer/portal/1).

在您开始之前，请参阅[目前待解决的问题清单](http://jira.perfect.org:8080/projects/ISS/issues).

=====

** ⚠️目前本资源采用 Swift *DEVELOPMENT-SNAPSHOT-2016-06-20-a* 快照版本编译，采用SPM软件包管理器。⚠️**

请确认您的平台上已经安装了相关依存关系：

[Dependencies](https://github.com/PerfectlySoft/Perfect/wiki/Dependencies)

编译后，本服务器能够与任何 FastCGI 服务器共同工作，可以使用 Unix套接字文件或TCP。

## Apache 2.4
如果您希望使用 Apache 2.4，请参考一下内容安装和运行mod_perfect FastCGI 模块：

[Perfect-FastCGI-Apache2.4](https://github.com/PerfectlySoft/Perfect-FastCGI-Apache2.4)

## NGINX
请参考下列内容安装 NGINX 并进行相关配置：

[NGINX](https://github.com/PerfectlySoft/Perfect/wiki/NGINX)

## 编译和运行：

以下代码展示了如何创建空白项目并运行：

```
git clone https://github.com/PerfectlySoft/PerfectTemplateFCGI.git
cd PerfectTemplateFCGI
swift build
.build/debug/PerfectTemplateFCGI
```

您应该能看到如下输出信息：

```
Starting FastCGI server on named pipe /Library/WebServer/VirtualHosts/perfect.fastcgi.sock
```

这意味这服务器已经准备好并且等待连接，

## 示范网页

以下代码包括了一个非常简单的“你好，世界！”例子。请注意您必须为 FastCGI 安装 mod_perfect 模块，并改变命名管道使之指向服务器文档根目录。

```swift
import PerfectLib
import PerfectFastCGI

// 初始化基础服务
PerfectServer.initializeServices()

Routing.Routes["/**"] = {
    req, resp in
    let path = req.path
    resp.appendBody(string: "<html><meta http-equiv=Content-Type content="text/html;charset=utf-8"><title>祝贺</title><body>你好，世界！</body></html>")
    resp.completed()
}

do {
    // 启动 FastCGI 服务器
    // 指向套接字文件的路径必须指向文档根目录上一层文件夹。
    // 文件名必须是 "perfect.fastcgi.sock"
    // 比如，以下路径会指向的文档根目录是：
    // /Library/WebServer/VirtualHosts/wwwroot/
    try FastCGIServer().start(namedPipe: "/Library/WebServer/VirtualHosts/perfect.fastcgi.sock")
} catch {
    print("发生错误： \(error)")
}
```



## 更多信息
详细信息请参考 Perfect 项目，详见官网[perfect.org](http://perfect.org).
