//
//  XJHousePreviewView.h
//  TTLive
//
//  Created by Dear on 16/9/19.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJUserModel;

@interface XJHousePreviewView : UIView

+ (instancetype)allocWithNib;
/**主播*/
@property(nonatomic, strong) XJUserModel *live;
/**显示*/
- (void)show;
/**隐藏*/
- (void)hide;
@end
