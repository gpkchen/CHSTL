# ZHSTL

[![CI Status](http://img.shields.io/travis/lmw/ZHSTL.svg?style=flat)](https://travis-ci.org/lmw/ZHSTL)
[![Version](https://img.shields.io/cocoapods/v/ZHSTL.svg?style=flat)](http://cocoapods.org/pods/ZHSTL)
[![License](https://img.shields.io/cocoapods/l/ZHSTL.svg?style=flat)](http://cocoapods.org/pods/ZHSTL)
[![Platform](https://img.shields.io/cocoapods/p/ZHSTL.svg?style=flat)](http://cocoapods.org/pods/ZHSTL)

## 前言
1.    什么是CocoaPods<br/>
CocoaPods是swift和Objective-C依赖管理平台。它拥有超过3万7000个代码库，超过250万个应用程序在用它进行管理。CocoaPods可以帮助优化项目的库管理。
以上是官方描述，事实上，经过测试，CocoaPods可以管理任何编码格式的文件。
2.    为什么要使用CocoaPods私服<br/>
目前公司IOS端app已有多款，并且有继续开发多款的需求，那么同一套基础代码需要被运用到多个app中，万一发现问题需要修改，目前的办法是每个工程改一遍（如果是4个app那就需要同一个地方改4遍）。为了优化这种现象，并且为以后模块化开发打基础，决定引入CocoaPods私服做共有模块抽取管理。

## 示例

如果需要执行或者维护示例代码，直接把本工程clone到本地，在'Example'文件夹执行'pod install'后执行

## 要求

本库需在iOS8.0及以上版本使用

## 安装

1.确保本地已经安装CocoaPods<br/>
2.添加公共库私有源：<br/>
为保障添加成功，首先执行移除指令确保本地无'ZHSpecsRepo'源：<br/>
```ruby
pod repo remove ZHSpecsRepo
```
添加'ZHSpecsRepo'源：<br/>
```ruby
pod repo add ZHSpecsRepo 'http://git.fintechzh.com/iOS/ZHSpecsRepo.git'
```
3.需要在Podfile中引入本私有源和CocoaPods官方源：<br/>
```ruby
source 'http://git.fintechzh.com/iOS/ZHSpecsRepo.git'
source 'https://github.com/CocoaPods/Specs.git'
```
4.Podfile引入本库：<br/>
```ruby
pod 'ZHSTL'
```
5.执行安装<br/>
```ruby
pod install/pod update
```

## 维护

1.clone本库到本地。<br/>
2.将新加的模块文件放于/ZHSTL/Classes目录，资源文件放于/ZHSTL/Assets目录。<br/>
3.到ZHSTL/Example执行更新指令：<br/>
```ruby
pod update
```
4.用示例代码进行测试，确保无误后修改/ZHSTL.podspec文件中的版本号，并推送到master分支<br/>
5.从master分支创建一个新分支，分支名必须为/ZHSTL.podspec文件中的版本号<br/>
6.在/ZHSTL.podspec文件路径下执行指令验证/ZHSTL.podspec有效性：<br/>
```ruby
pod lib lint --use-libraries --allow-warnings
```
7.执行指令更新私有源：<br/>
```ruby
pod repo push ZHSpec ZHSTL.podspec --use-libraries --allow-warnings
```
8.到具体代码工程主目录执行更新指令：<br/>
```ruby
pod update
```

<<<<<<< HEAD
## License

ZHSTL is available under the MIT license. See the LICENSE file for more info.

=======

## License

ZHSTL is available under the MIT license. See the LICENSE file for more info.
>>>>>>> 3a4fc55ed71dd3c2cb841af69793f9e5d5d15e73
