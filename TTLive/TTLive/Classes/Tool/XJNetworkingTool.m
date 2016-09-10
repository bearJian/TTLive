//
//  XJNetworkingTool.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJNetworkingTool.h"

@implementation XJNetworkingTool
static XJNetworkingTool *_manager;

+ (instancetype)shareTool{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 创建
        _manager = [XJNetworkingTool manager];
        // 设置超时时间
        _manager.requestSerializer.timeoutInterval = 5.0;
        // 设置接受的类型
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
    });
    return _manager;
}

// 判断网络类型
+ (NetworkStates)getNetworkStates{
    // iOS 判断当前是2G,3G,4G
    NSArray *subviews = [[[[UIApplication sharedApplication] valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    // 保存网络状态
    NetworkStates states = NetworkStatesNone;
    // 获取到网络返回码
    for (id child in subviews) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            // 获取到状态栏
            int networkType = [[child valueForKeyPath:@"dataNetworkType"] intValue];
            switch (networkType) {
                case 0:
                    states = NetworkStatesNone; // 没有网络
                    break;
                case 1:
                    states = NetworkStates2G; // 2G
                    break;
                case 2:
                    states = NetworkStates3G; // 3G
                    break;
                case 3:
                    states = NetworkStates4G; // 4G
                    break;
                case 5:
                    states = NetworkStatesWifi; // Wifi
                    break;
                default:
                    break;
            }
        }
    }
    // 根据状态选择
    return states;
}
@end
