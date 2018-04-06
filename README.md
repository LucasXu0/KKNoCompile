# KKNoCompile
实现 iOS 不编译即可更新代码的一种方案

## 视频展示
http://ocnnxadky.bkt.clouddn.com/KK_NO_COMPILE_DEMO.mp4

# 使用说明
1. 安装 `node.js`
2. 下载本项目
2. 编译 `KK_NODE_COMPILE_EDITOR_EXTENSION` 中的 `Xcode Editor Extension`，将生成 `.app` 移动在应用中即可使用
3. 使用 `node` 执行 `Node_Server` 中的 `NOCOMPILE_NODE_SERVER.js` 脚本
4. 集成 `NO_COMPILE_Libs` 到你的项目中(需要添加 `JavaScriptCore.framework`)
5. 在项目启动后执行

```
[KKNoCompileEngine startEngineWithJSPath:@"/Users/TsuiYuenHong/Desktop/main.js" host:@"127.0.0.1" port:9527];
```

6. 选中你需要修改的代码，并在 Xcode 的菜单中选择 Editor -> NOCOMPILE_Extension 即可修改

**注意** :
1. `JSPath` 需修改为你指定的路径
2. `JSPath/host/port` 参数如果需要修改需要 **同步** 到 `NOCOMPILE_NODE_SERVER.js` 中方可生效
