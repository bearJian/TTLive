//
//  XJUserView.h
//  TTLive
//
//  Created by Dear on 16/9/27.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJUserModel;

@interface XJUserView : UIView

+ (instancetype)userView;

/** 用户信息 */
@property (nonatomic, strong) XJUserModel *user;
/** 点击关闭 */
@property (nonatomic, copy) void (^closeBlock)();

@end
