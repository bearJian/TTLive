//
//  XJLiveHouseViewController.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XJLiveHouseViewController : UICollectionViewController
/** 直播间list */
@property (nonatomic, strong) NSArray *lives;
/** 当前的index */
@property (nonatomic, assign) NSUInteger currentIndex;
/** 观看的人数 */
@property (nonatomic, assign) NSUInteger seeCount;
@end
