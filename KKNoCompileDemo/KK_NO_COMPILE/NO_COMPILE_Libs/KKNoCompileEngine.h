//
//  KKNoCompileEngine.h
//  KK_NO_COMPILE
//
//  Created by TsuiYuenHong on 2017/9/8.
//  Copyright © 2017年 TsuiYuenHong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKNoCompileEngine : NSObject

/**
 配置基础参数
 
 @param jsPath  注入 js 的文件路径
 @param address 本地服务器的地址
 @param port    本地服务器的端口
 */

+ (void)startEngineWithJSPath:(NSString *)jsPath host:(NSString *)host port:(uint16_t)port;

+ (void)enableDebugLog:(BOOL)enable;

@end
