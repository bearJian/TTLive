//
//  UIImageView+XJGif.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "UIImageView+XJGif.h"

@implementation UIImageView (XJGif)
// 播放GIF
- (void)playGifAnim:(NSArray *)images
{
    if (!images.count) {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = 0.5;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)stopGifAnim
{
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
@end
