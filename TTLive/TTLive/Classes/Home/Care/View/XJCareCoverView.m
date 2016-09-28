//
//  XJCareCoverView.m
//  TTLive
//
//  Created by Dear on 16/9/28.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCareCoverView.h"

@interface XJCareCoverView()
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;

@end

@implementation XJCareCoverView

-(void)awakeFromNib{
    self.hotBtn.layer.borderWidth = 1;
    self.hotBtn.layer.borderColor = KeyColor.CGColor;
    self.hotBtn.layer.cornerRadius = self.hotBtn.xj_height * 0.5;
    [self.hotBtn.layer masksToBounds];
    
    [self.hotBtn setTitleColor:KeyColor forState:UIControlStateNormal];
}

+ (instancetype)coverView{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"XJCareCoverView" owner:nil options:nil]lastObject];
}
- (IBAction)hotLiveBtn:(id)sender {
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyToHotVC object:nil];
}

@end
