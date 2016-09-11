//
//  UIView+XJExtention.h
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XJExtention)
/** X */
@property (nonatomic, assign) CGFloat xj_x;

/** Y */
@property (nonatomic, assign) CGFloat xj_y;

/** Width */
@property (nonatomic, assign) CGFloat xj_width;

/** Height */
@property (nonatomic, assign) CGFloat xj_height;

/** size */
@property (nonatomic, assign) CGSize xj_size;

/** centerX */
@property (nonatomic, assign) CGFloat xj_centerX;

/** centerY */
@property (nonatomic, assign) CGFloat xj_centerY;


// 判断View是否在窗口上
- (BOOL)isShowingOnKeyWindow;
@end
