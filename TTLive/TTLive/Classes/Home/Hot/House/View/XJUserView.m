//
//  XJUserView.m
//  TTLive
//
//  Created by Dear on 16/9/27.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJUserView.h"
#import "XJUserModel.h"
#import "XJCareData.h"

@interface XJUserView()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;
@property (weak, nonatomic) IBOutlet UILabel *careNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanceNumLabel;
@property (weak, nonatomic) IBOutlet UIView *userView;
@property (nonatomic, strong) XJUserModel *userModel;
@end

@implementation XJUserView

+ (instancetype)userView{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.careNumLabel.text = [NSString stringWithFormat:@"%d", arc4random_uniform(5000) + 500];
    self.fanceNumLabel.text = [NSString stringWithFormat:@"%d", arc4random_uniform(30000) + 500];
    self.userView.layer.cornerRadius = 10;
    self.userView.layer.masksToBounds = YES;
}

- (void)getUserModal:(XJUserModel *)userModal{
    self.userModel = userModal;
    NSLog(@"userModel++++++%@",self.userModel);
}

-(void)setUser:(XJUserModel *)user{
    
    _user = user;
    self.nameLabel.text = user.nickname;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.iconImage.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
            });
        }];
}

- (IBAction)careBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected){
        NSLog(@"userModel++++++%@",self.userModel);
        [[XJCareData shareCareData] saveData:_userModel];
        [MBProgressHUD showSuccess:@"关注成功"];
    }else{
        if ([[XJCareData shareCareData].allModels isEqualToArray:self.allModel]){
            
            sender.selected = YES;
            [MBProgressHUD showError:@"不能取消,请点击别的取消按钮"];
        }else{
            [[XJCareData shareCareData] unsaveData:self.userModel];
            [MBProgressHUD showSuccess:@"取消关注成功"];
        }
    }
}

- (IBAction)closeWindowBtn:(UIButton *)sender {
    
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (IBAction)reportBtn:(UIButton *)sender {

    [MBProgressHUD showText:@"举报成功"];
}

@end
