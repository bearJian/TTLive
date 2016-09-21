//
//  XJNewStarCell.m
//  TTLive
//
//  Created by Dear on 16/9/20.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJNewStarCell.h"
#import "XJUserModel.h"

@interface XJNewStarCell()
/**封面*/
@property (weak, nonatomic) IBOutlet UIImageView *starImage;
/**昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**位置*/
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
/**标识*/
@property (weak, nonatomic) IBOutlet UIImageView *tagImage;

@end
@implementation XJNewStarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setUser:(XJUserModel *)user{
    _user = user;
    // 封面
    [self.starImage sd_setImageWithURL:[NSURL URLWithString:user.photo] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    // 是否是新主播
    self.tagImage.hidden = !user.newStar;
    // 地址
    [self.addressBtn setTitle:user.position forState:UIControlStateNormal];
    // 昵称
    self.nameLabel.text = user.nickname;
}

// 内存警告时的处理
- (void)didReceiveMemoryWarning{
    
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}


@end
