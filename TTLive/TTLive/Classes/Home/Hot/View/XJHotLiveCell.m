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
    
    NSString *allNum = [NSString stringWithFormat:@"%ld人再观看", live.allnum];
    // 创建富文本
    NSRange range = [allNum rangeOfString:[NSString stringWithFormat:@"%ld", live.allnum]];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:allNum];
    [att addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    [att addAttribute:NSForegroundColorAttributeName value:KeyColor range:range];
    self.seeCountL.attributedText = att;
    // 这种创建方式适用于整体控制
//    NSMutableDictionary *att = [NSMutableDictionary dictionary];
//    att[NSFontAttributeName] = [UIFont systemFontOfSize:15];
//    att[NSForegroundColorAttributeName] = KeyColor;
//    
//    self.seeCountL.attributedText = [[NSAttributedString alloc] initWithString:allNumFull attributes:att];
}

// 内存警告时的处理
- (void)didReceiveMemoryWarning{
    
    [[SDWebImageManager sharedManager].imageCache clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
}


@end
