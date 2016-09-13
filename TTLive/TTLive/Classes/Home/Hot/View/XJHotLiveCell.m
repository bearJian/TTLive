//
//  XJHotLiveCell.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHotLiveCell.h"
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

@end
@implementation XJHotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)setLive:(XJLiveModel *)live{
    _live = live;
    
}

@end
