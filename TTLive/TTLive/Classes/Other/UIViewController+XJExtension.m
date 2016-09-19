//
//  UIViewController+XJExtension.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "UIViewController+XJExtension.h"
#import "UIViewController+XJExtension.h"
#import "UIImageView+XJGif.h"
#import <objc/message.h>

static const void *GifKey = &GifKey;
@implementation UIViewController (XJExtension)

-(UIImageView *)gifView{
    
    return objc_getAssociatedObject(self, GifKey);
}

-(void)setGifView:(UIImageView *)gifView{
    
    return objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showGifLoding:(NSArray *)images inView:(UIView *)view{
    
    if (!images.count) {
        images = @[[UIImage imageNamed:@"hold1_60x72"], [UIImage imageNamed:@"hold2_60x72"], [UIImage imageNamed:@"hold3_60x72"]];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@70);
    }];
    self.gifView = gifView;
    // 播放
    [gifView playGifAnim:images];
}


- (void)hideGifLoding{
    
    [self.gifView stopGifAnim];
    self.gifView = nil;
}


- (BOOL)isNotEmpty:(NSArray *)array{
    
    if ([array isKindOfClass:[NSArray class]] && array.count) {
        return YES;
    }
    return NO;
}

@end
