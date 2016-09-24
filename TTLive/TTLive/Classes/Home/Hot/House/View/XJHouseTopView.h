//
//  XJTopView.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XJLiveModel, XJUserModel, XJScrollTextView;

@interface XJHouseTopView : UIView
+ (instancetype)allocWithNib;
/** 主播 */
@property(nonatomic, strong) XJUserModel *user;
/** 直播 */
@property(nonatomic, strong) XJLiveModel *live;
/** 点击开关  */
@property(nonatomic, copy)void (^clickOpenBtnBlock)(bool selected);
/**scrollView*/
@property (nonatomic, strong) XJScrollTextView *scrollText;
/**点击按钮方法*/
- (void)keepSelectState;

@end
