//
//  PrefixHeader.h
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#ifndef PrefixHeader_h
#define PrefixHeader_h

#import <IJKMediaFramework/IJKMediaFramework.h>
#import "XJNetworkingTool.h"
#import "UIView+XJExtention.h"
#import "MBProgressHUD+XJ.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "UIDevice+XJExtension.h"
#import "UIImage+XJExtension.h"
#import <MJExtension.h>
#import "UIViewController+XJExtension.h"
#import <MJRefresh.h>

#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"

#pragma mark - Frame相关
// 屏幕宽/高
#define XJScreenW  [UIScreen mainScreen].bounds.size.width
#define XJScreenH [UIScreen mainScreen].bounds.size.height
#define TopViewW 70 // 按钮的宽
#define TopViewS 10 // 间距

#pragma mark - 颜色
// 颜色相关
#define Color(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define KeyColor Color(216, 41, 116)

#pragma mark - 通知
// 当前没有关注的主播, 去看热门主播
#define kNotifyToHotVC @"kNotifyToHotVC"
// 点击了用户
#define kNotifyClickUser @"kNotifyClickUser"

#endif /* PrefixHeader_h */
