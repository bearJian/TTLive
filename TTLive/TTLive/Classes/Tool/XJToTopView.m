//
//  XJToTopView.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJToTopView.h"

@implementation XJToTopView

static UIButton *_btn;

// 第一次使用类的时候调用
+ (void)initialize{
    UIButton *btn = [[UIButton alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    // 添加监听
    [btn addTarget:self action:@selector(statusBarClick) forControlEvents:UIControlEventTouchUpInside];
    [[self statusBarView] addSubview:btn];
    // 隐藏按钮
    btn.hidden = YES;
    _btn = btn;
}


// 展示
+ (void)show{
    _btn.hidden = NO;
}

// 隐藏
+ (void)hide{
    _btn.hidden = YES;
}


/**点击状态栏调用*/
+ (void)statusBarClick{
    NSLog(@"点击了状态栏,请指示...");
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollView:window];
}

// 循环查找UIScrollview
+ (void)searchScrollView:(UIView *)superview{
    for (UIScrollView *subview in superview.subviews) {
        // 如果是scrollview,并且在window上,滚动到最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            // 滚动
            [subview setContentOffset:offset animated:YES];
        }
    }
}

// 获取当前状态栏的方法
/**
 *  调用了瓶的私有API
 *  调用这个方法就可以拿到系统的状态栏对象，是个UIView。那么我们可以改变状态栏的颜色，大小位置（frame）等等。
 */
+ (UIView *)statusBarView{
    UIView *statusBar = nil;
    NSData *data = [NSData dataWithBytes:(unsigned char []){0x73, 0x74, 0x61, 0x74, 0x75, 0x73, 0x42, 0x61, 0x72} length:9];
    NSString *key = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    id object = [UIApplication sharedApplication];
    if ([object respondsToSelector:NSSelectorFromString(key)]) {
        // 取出对象 赋值
        statusBar = [object valueForKey:key];
    }
    return statusBar;
}

@end
