//
//  XJNetworkingTool.h
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

typedef NS_ENUM(NSUInteger, NetworkStates) {
    NetworkStatesNone, // 没有网络
    NetworkStates2G, // 2G
    NetworkStates3G, // 3G
    NetworkStates4G, // 4G
    NetworkStatesWifi // Wifi
};

@interface XJNetworkingTool : AFHTTPSessionManager
// 创建单例
+ (instancetype)shareTool;
// 判断网络类型
+ (NetworkStates)getNetworkStates;
@end
