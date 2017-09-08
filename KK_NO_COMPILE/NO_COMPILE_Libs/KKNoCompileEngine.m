//
//  KKNoCompileEngine.m
//  KK_NO_COMPILE
//
//  Created by TsuiYuenHong on 2017/9/8.
//  Copyright © 2017年 TsuiYuenHong. All rights reserved.
//

#import "KKNoCompileEngine.h"
#import "JPEngine.h"
#import "GCDAsyncSocket.h"

@interface KKNoCompileEngine () <GCDAsyncSocketDelegate>

@property (nonatomic, copy)     NSString *jsPath;

@property (nonatomic, strong)   GCDAsyncSocket *socket;

@property (nonatomic, copy)     NSString *host;
@property (nonatomic, assign)   uint16_t port;

//@property (nonatomic, assign)   BOOL enableDebugLog;

@end

@implementation KKNoCompileEngine

+ (void)startEngineWithJSPath:(NSString *)jsPath host:(NSString *)host port:(uint16_t)port{
    [[KKNoCompileEngine sharedEngine] startEngineWithJSPath:jsPath host:host port:port];
}

static KKNoCompileEngine *_instance;
+ (instancetype)sharedEngine{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        enableDebugLog = NO;
    });
    return _instance;
}

- (void)startEngineWithJSPath:(NSString *)jsPath host:(NSString *)host port:(uint16_t)port{
    
    self.jsPath = jsPath;
    self.host = host;
    self.port = port;
    
    // 配置 JSPatch
    [JPEngine startEngine];
    
    // 配置 socket
    NSError *error;
    self.socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self.socket connectToHost:host onPort:port error:&error];
    if (error) {
        KKDebugLog([NSString stringWithFormat:@"机甲连接失败 %@",error]);
    }else{
        [self.socket readDataWithTimeout:-1 tag:0];
        KKDebugLog(@"机甲启动成功");
    }
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port{
    if (host == self.host && port == self.port) {
        KKDebugLog([NSString stringWithFormat:@"机甲已连接 %@:%d",host,port]);
    }
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    KKDebugLog(@"机甲开始修复");
    [JPEngine evaluateScriptWithPath:self.jsPath];
    KKDebugLog(@"机甲注入成功");
    [self.socket readDataWithTimeout:-1 tag:0];
    KKDebugLog(@"机甲完成修复");
}

+ (void)enableDebugLog:(BOOL)enable
{
    enableDebugLog = enable;
}

bool enableDebugLog;
void KKDebugLog(NSString *info){
    if (enableDebugLog) {
        NSLog(@"-KKNoCompileEngine- :%@",info);
    }
}

@end
