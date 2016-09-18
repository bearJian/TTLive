//
//  XJTopView.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHouseTopView.h"

@interface XJHouseTopView()
/**主播栏*/
@property (weak, nonatomic) IBOutlet UIView *UserView;
/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
/**昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**人数*/
@property (weak, nonatomic) IBOutlet UILabel *seeNumLabel;
/**按钮*/
@property (weak, nonatomic) IBOutlet UIButton *openBtn;
/**观众*/
@property (weak, nonatomic) IBOutlet UIScrollView *peopleScrollView;
/**礼物*/
@property (weak, nonatomic) IBOutlet UIButton *giftBtn;

@end
@implementation XJHouseTopView

-(void)awakeFromNib{
    
    [self makeRadiusOfView:self.UserView];
    [self makeRadiusOfView:self.iconImage];
    [self makeRadiusOfView:self.openBtn];
    [self makeRadiusOfView:self.giftBtn];
    
    // 设置头像边框
    self.iconImage.layer.borderWidth = 1;
    self.iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    [self.openBtn setBackgroundImage:@"" forState:UIControlStateNormal];
    
}

// 设置圆角
- (void)makeRadiusOfView:(UIView *)view{
    view.layer.cornerRadius = view.xj_height * 0.5;
    // 裁剪
    view.layer.masksToBounds = YES;
}

@end
