//
//  UIImageView+XJGif.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XJGif)
// 播放GIF
- (void)playGifAnim:(NSArray *)images;
// 停止动画
- (void)stopGifAnim;
@end
