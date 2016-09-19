//
//  XJHouseBottomView.h
//  TTLive
//
//  Created by Dear on 16/9/19.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, LiveToolType) {
    LiveToolTypePublicTalk,
    LiveToolTypePrivateTalk,
    LiveToolTypeGift,
    LiveToolTypeRank,
    LiveToolTypeShare,
    LiveToolTypeClose
};

@interface XJHouseBottomView : UIView
/**点击工具栏*/
@property (nonatomic, copy) void (^clickTollBlock)(LiveToolType type);

@end
