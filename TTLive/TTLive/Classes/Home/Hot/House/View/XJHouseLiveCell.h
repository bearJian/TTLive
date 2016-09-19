//
//  XJLiveCell.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJLiveModel;

@interface XJHouseLiveCell : UICollectionViewCell
/**直播*/
@property (nonatomic, strong) XJLiveModel *live;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;

@end
