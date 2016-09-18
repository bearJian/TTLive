//
//  UIImage+XJExtension.h
//  TTLive
//
//  Created by Dear on 16/9/14.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (XJExtension)
/**
 *  生成圆角的图片
 *
 *  @param originImage 原始图片
 *  @param borderColor 边框原色
 *  @param borderWidth 边框宽度
 *
 *  @return 圆形图片
 */
+ (UIImage *)circleImage:(UIImage *)originImage borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;
@end
