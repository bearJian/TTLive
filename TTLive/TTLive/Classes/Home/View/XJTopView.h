//
//  XJTopView.h
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, topType){
    topTypeHot, // 热门
    topTypeNew, // 最新
    topTypeCare // 关注
};
@interface XJTopView : UIView
/**滑动选中的按钮*/
@property (nonatomic, assign) topType selectBtnType;
/**选中block*/
@property (nonatomic, copy) void (^selectBlock)(topType type);
/**下划线*/
@property (nonatomic, weak, readonly) UIView *line;
@end
