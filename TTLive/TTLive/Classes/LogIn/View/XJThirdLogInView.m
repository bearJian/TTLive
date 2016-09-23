//
//  XJThirdLogInView.m
//  TTLive
//
//  Created by Dear on 16/9/22.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJThirdLogInView.h"

@implementation XJThirdLogInView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    UIImageView *qq = [self creatImageView:@"qqloginicon_60x60" tag:LoginTypeQQ];
    UIImageView *sina = [self creatImageView:@"wbLoginicon_60x60" tag:LoginTypeSina];
    UIImageView *wechat = [self creatImageView:@"wxloginicon_60x60" tag:LoginTypeWechat];
    
    [self addSubview:qq];
    [self addSubview:sina];
    [self addSubview:wechat];
    
    [sina mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@60);
    }];
    
    [qq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.right.equalTo(sina.mas_left).offset(-20);
        make.size.equalTo(sina);
    }];
    
    [wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(sina);
        make.left.equalTo(sina.mas_right).offset(20);
        make.size.equalTo(sina);
    }];
    
}

- (UIImageView *)creatImageView:(NSString *)imageName tag:(NSUInteger)tag
{
    UIImageView *imageV = [[UIImageView alloc] init];
    imageV.image = [UIImage imageNamed:imageName];
    imageV.tag = tag;
    imageV.userInteractionEnabled = YES;
    [imageV addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)]];
    return imageV;
}


- (void)click:(UITapGestureRecognizer *)tapRec
{
    if (self.clickLogin) {
        self.clickLogin(tapRec.view.tag);
    }
}


@end
