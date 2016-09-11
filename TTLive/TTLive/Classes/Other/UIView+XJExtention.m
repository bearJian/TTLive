//
//  UIView+XJExtention.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "UIView+XJExtention.h"

@implementation UIView (XJExtention)

- (void)setXj_x:(CGFloat)xj_x
{
    CGRect frame = self.frame;
    frame.origin.x = xj_x;
    self.frame = frame;
}

- (void)setXj_y:(CGFloat)xj_y
{
    CGRect frame = self.frame;
    frame.origin.y = xj_y;
    self.frame= frame;
}

- (void)setXj_width:(CGFloat)xj_width{
    CGRect frame = self.frame;
    frame.size.width = xj_width;
    self.frame = frame;
}

- (void)setXj_height:(CGFloat)xj_height
{
    CGRect frame = self.frame;
    frame.size.height = xj_height;
    self.frame = frame;
}

- (void)setXj_size:(CGSize)xj_size
{
    CGRect frame = self.frame;
    frame.size = xj_size;
    self.frame = frame;
}

- (CGFloat)xj_x
{
    return self.frame.origin.x;
}

- (CGFloat)xj_y
{
    return self.frame.origin.y;
}

- (CGFloat)xj_width
{
    return self.frame.size.width;
}

- (CGFloat)xj_height
{
    return self.frame.size.height;
}

- (CGSize)xj_size
{
    return self.frame.size;
}

- (CGFloat)xj_centerX
{
    return self.center.x;
}

- (CGFloat)xj_centerY
{
    return self.center.y;
}

- (void)setXj_centerX:(CGFloat)xj_centerX
{
    CGPoint center = self.center;
    center.x = xj_centerX;
    self.center = center;
}

- (void)setXj_centerY:(CGFloat)xj_centerY
{
    CGPoint center = self.center;
    center.y = xj_centerY;
    self.center = center;
}

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
