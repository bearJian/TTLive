//
//  XJThirdLogInView.h
//  TTLive
//
//  Created by Dear on 16/9/22.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LoginType) {
    LoginTypeQQ,      // 0
    LoginTypeSina,    // 1
    LoginTypeWechat   // 2
};

@interface XJThirdLogInView : UIView
/** 点击按钮 */
@property (nonatomic, copy) void (^clickLogin)(LoginType type);
@end
