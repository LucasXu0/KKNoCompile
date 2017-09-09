//
//  SourceEditorCommand.m
//  NOCOMPILE_Extension
//
//  Created by TsuiYuenHong on 2017/9/4.
//  Copyright © 2017年 TsuiYuenHong. All rights reserved.
//

#import "SourceEditorCommand.h"

@implementation SourceEditorCommand

- (void)performCommandWithInvocation:(XCSourceEditorCommandInvocation *)invocation completionHandler:(void (^)(NSError * _Nullable nilOrError))completionHandler
{
    // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.

    // 获取需要修改的代码
    XCSourceTextBuffer *buffer = invocation.buffer;
    NSInteger startLine = buffer.selections[0].start.line;
    NSInteger endLine = buffer.selections[0].end.line;
    NSString *input = @"";
    
    for (NSInteger i = 0; i < invocation.buffer.lines.count; i++) {
        if ([invocation.buffer.lines[i] containsString:@"@implementation"]) {
            input = [input stringByAppendingString:buffer.lines[i]];
            break;
        }
    }
    
    for (NSInteger i = startLine; i <= endLine; i++) {
        input = [input stringByAppendingString:buffer.lines[i]];
    }
    
    input = [input stringByAppendingString:@"@end"];
    NSLog(@"原始数据:%@",input);
    
    input = [self encodeBase64String:input];
    NSLog(@"Decode数据:%@",input);
    
    [self sendRequestToUpdateMainJS:input];
    
    completionHandler(nil);
}

- (void)sendRequestToUpdateMainJS:(NSString *)inputString
{
    NSString *urlString = [NSString stringWithFormat:@"http://localhost:9526/?filename=/Users/TsuiYuenHong/Desktop/main.js&inputstring='%@'",inputString];
    NSURL *url = [NSURL URLWithString:urlString];
    NSLog(@"请求URL:%@",url);
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:
                                      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                          NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                                      }];
    [dataTask resume];
}

- (NSString *)encodeBase64String:(NSString *)stringToEncode
{
    NSData *dataToEncode = [stringToEncode dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encodedData = [dataToEncode base64EncodedDataWithOptions:0];
    NSString *encodedString = [[NSString alloc] initWithData:encodedData encoding:NSUTF8StringEncoding];
    return encodedString;
}

@end
