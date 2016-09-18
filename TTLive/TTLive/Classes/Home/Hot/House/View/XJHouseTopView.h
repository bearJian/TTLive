//
//  XJTopView.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XJLiveModel, XJUserModel;

@interface XJHouseTopView : UIView
/** 主播 */
@property(nonatomic, strong) XJUserModel *user;
/** 直播 */
@property(nonatomic, strong) XJLiveModel *live;


@end
