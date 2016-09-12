//
//  XJCareViewController.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCareViewController.h"

@interface XJCareViewController ()
@property (weak, nonatomic) IBOutlet UIButton *hotBtn;

@end

@implementation XJCareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hotBtn.layer.borderWidth = 1;
    self.hotBtn.layer.borderColor = KeyColor.CGColor;
    self.hotBtn.layer.cornerRadius = self.hotBtn.xj_height * 0.5;
    [self.hotBtn.layer masksToBounds];
    
    [self.hotBtn setTitleColor:KeyColor forState:UIControlStateNormal];
}


- (IBAction)toHotVC:(id)sender {
    // 发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyToHotVC object:nil];
}

@end
