# KK_NO_COMPILE
实现 iOS 不编译即可更新代码的一种方案

## 视频展示
http://ocnnxadky.bkt.clouddn.com/KK_NO_COMPILE_DEMO.mp4

# 使用说明
1. 安装 `node.js`
2. 下载本项目
3. 使用 `node` 执行 `Node_Server` 中的 `NOCOMPILE_NODE_SERVER.js` 脚本
4. 集成 `NO_COMPILE_Libs` 到你的项目中(需要添加 `JavaScriptCore.framework`)
5. 在项目启动后执行

```
[KKNoCompileEngine startEngineWithJSPath:@"/Users/TsuiYuenHong/Desktop/main.js" host:@"127.0.0.1" port:9527];
```

**注意** :
1. `JSPath` 需修改为你指定的路径
2. `JSPath/host/port` 参数如果需要修改需要 **同步** 到 `NOCOMPILE_NODE_SERVER.js` 中方可生效
