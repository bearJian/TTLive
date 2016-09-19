//
//  XJHouseBottomView.m
//  TTLive
//
//  Created by Dear on 16/9/19.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHouseBottomView.h"

@implementation XJHouseBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (NSArray *)tools
{
    return @[@"talk_public_40x40", @"talk_private_40x40", @"talk_sendgift_40x40", @"talk_rank_40x40", @"talk_share_40x40", @"talk_close_40x40"];
}
    
- (void)setup{
    CGFloat wh = 40;
    CGFloat margin = (XJScreenW - wh * self.tools.count) / (self.tools.count + 1.0);
    CGFloat x = 0;
    CGFloat y = 0;
    // 创建控件
    for (int i = 0; i < self.tools.count; i++) {
        x = margin + (wh + margin) * i;
        UIImageView *toolView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        toolView.userInteractionEnabled = YES;
        toolView.tag = i;
        toolView.image = [UIImage imageNamed:self.tools[i]];
        // 添加手势
        [toolView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickTool:)]];
        [self addSubview:toolView];
    }
}

- (void)clickTool:(UITapGestureRecognizer *)tap{
    
    if (self.clickTollBlock) {
        self.clickTollBlock(tap.view.tag);
    }
}

@end
