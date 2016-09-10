//
//  UIView+XJExtention.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "UIView+XJExtention.h"

@implementation UIView (XJExtention)
// 判断View是否在窗口上
- (BOOL)isShowingOnKeyWindow{
    // 主窗口
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    
    // 以主窗口左上角为坐标原点, 计算self的矩形框
    CGRect newFrame = [keyWindow convertRect:self.frame fromView:self.superview];
    CGRect winBounds = keyWindow.bounds;
    
    // 主窗口的bounds 和 self的矩形框 是否有重叠
    BOOL intersects = CGRectIntersectsRect(newFrame, winBounds);
    
    return !self.isHidden && self.alpha > 0.01 && self.window == keyWindow && intersects;
}

@end
