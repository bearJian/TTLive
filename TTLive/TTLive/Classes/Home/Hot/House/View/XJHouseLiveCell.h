//
//  XJLiveCell.h
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XJLiveModel, XJUserModel;

@interface XJHouseLiveCell : UICollectionViewCell
/**直播*/
@property (nonatomic, strong) XJLiveModel *live;
/** 父控制器 */
@property (nonatomic, weak) UIViewController *parentVc;
/** 预览直播 */
@property (nonatomic, strong) XJUserModel *previewLive;
/**点击预览直播*/
@property (nonatomic, copy) void (^clickPreviewLiveBlock)();
@end
