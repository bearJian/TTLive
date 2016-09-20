//
//  XJRefreshGifHeader.m
//  TTLive
//
//  Created by Dear on 16/9/20.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJRefreshGifHeader.h"

@implementation XJRefreshGifHeader
-(instancetype)init{
    
    if (self = [super init]) {
        // 隐藏上次刷新时间
        self.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        self.stateLabel.hidden = YES;
        NSArray *arry = @[[UIImage imageNamed:@"reflesh1_60x55"], [UIImage imageNamed:@"reflesh2_60x55"], [UIImage imageNamed:@"reflesh3_60x55"]];
        [self setImages:arry forState:MJRefreshStateRefreshing];
        [self setImages:arry forState:MJRefreshStatePulling];
        [self setImages:arry forState:MJRefreshStateIdle];
    }
    return self;
}

@end
