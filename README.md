# Straycat

![](Straycat-logo.png)

![](https://img.shields.io/badge/Swift-4.0-orange.svg)
![](https://img.shields.io/badge/CocoaPods-1.1+-green.svg)
![](https://img.shields.io/badge/License-GPL--3.0-blue.svg)

让你获取到更多的 Github 信息。

## 简介

由于 GitHub 在官方的接口中未提供 *Trending*，*Contributions* 等相关接口，所以打算使用前端 Parser 来爬取对应的信息。**Straycat** 是 **Sepicat** 的开源组件，用来获取 GitHub 接口中无法获取到的信息。

## 进度

- [x] **Trending** 信息获取。[link - 这个是官方的 Trending 信息](https://github.com/trending)
- [ ] **Contribution** 信息获取。[link - 这个是作者的 Contributions 页面](https://github.com/users/Desgard/contributions)
- [ ] **Octodex** 章鱼猫作品展。[link - octodex 主页](https://octodex.github.com)
- [ ] **githubrank** 中国区 GitHub 用户排行榜。[link - githubrank 排行版](http://githubrank.com/)
- [ ] **profile-summary-for-github.com** 数据分析聚合。[profile-summary-for-github](https://profile-summary-for-github.com/user/desgard)

## 依赖库

* Alamofire version 4.5+
* Kanna version 4.0+
* SwiftSoup version 1.6.3+

## 载入方式

**（包管理工具暂时仅支持 CocoaPods，且版本号需要 `1.1` 以上）**

```ruby
use_frameworks!

pod 'Straycat', :git => 'https://github.com/Sepicat/Straycat.git'
```

执行 `pod install` 的时候会自动安装依赖库，若原始项目中有相同的依赖，若无版本冲突也可。

## 使用

### Trending 获取

```Swift
import Straycat

// 使用 Kanna 解析，获取全部语言当日 Trending Developers
StrayTrending.shared.fetchDev(language: "all", time: .today, tool: .kanna) { 
    (success, devs) in
    guard success, let devs = devs else {
        // 爬取失败
        return
    }
    // 成功处理
}
```

## Sepicat 组件

欢迎支持已经上架的个人应用 Sepicat - 致力于打造最 Geekful 的 GitHub 客户端。

<a href="https://itunes.apple.com/cn/app/sepicat/id1355383210?mt=8">
<img src="https://linkmaker.itunes.apple.com/assets/shared/badges/zh-cht/appstore-lrg-513dfa9cea2b10efb09cbf38d8cb834a3aec771e41d6dfc273199a448420b91c.svg" />
</a>

## 数据源提供

倘若有更好的 GitHub 数据源，欢迎在 issue 中提供。

## GNU General Public License v3.0

Permissions of this strong copyleft license are conditioned on making available complete source code of licensed works and modifications, which include larger works using a licensed work, under the same license. Copyright and license notices must be preserved. Contributors provide an express grant of patent rights.
