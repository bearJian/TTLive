//
//  XJHotLiveCell.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHotLiveCell.h"
#import "XJLiveModel.h"
@interface XJHotLiveCell()
/**头像*/
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
/**昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**位置*/
@property (weak, nonatomic) IBOutlet UIButton *addressBtn;
/**评星*/
@property (weak, nonatomic) IBOutlet UIImageView *startImage;
/**观看人数*/
@property (weak, nonatomic) IBOutlet UILabel *seeCountL;
/**封面*/
@property (weak, nonatomic) IBOutlet UIImageView *coverImage;

@end
@implementation XJHotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // 选中样式设置
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


-(void)setLive:(XJLiveModel *)live{
    _live = live;
    // 头像
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 设置圆角图片
        image = [UIImage circleImage:image borderColor:[UIColor redColor] borderWidth:1];
        self.iconImage.image = image;
    }];
    // 昵称
    self.nameLabel.text = live.myname;
    // 位置
    if (!live.gps.length) {
        live.gps = @"来自星星的我";
    }
    [self.addressBtn setTitle:live.gps forState:UIControlStateNormal];
    // 封面
    [self.coverImage sd_setImageWithURL:[NSURL URLWithString:live.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    // 评星
    self.startImage.image = live.starImage;
    self.startImage.hidden = !live.starlevel;
    // 观看人数
    NSString *allNumFull = [NSString stringWithFormat:@"%ld人在看", live.allnum];
    // 创建富文本
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:allNumFull];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:17];
    att[NSForegroundColorAttributeName] = KeyColor;
    
    self.seeCountL.attributedText = [[NSAttributedString alloc] initWithString:allNumFull attributes:att];
}

@end
