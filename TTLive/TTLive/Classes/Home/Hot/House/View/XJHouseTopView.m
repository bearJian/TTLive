//
//  XJTopView.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHouseTopView.h"
#import "XJLiveModel.h"
#import "XJUserModel.h"

#define Space10 10
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
/**定时器*/
@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSArray *audienceArray;

@end

@implementation XJHouseTopView
static int randomNum = 0;

-(void)awakeFromNib{
    
    [self makeRadiusOfView:self.UserView];
    [self makeRadiusOfView:self.iconImage];
    [self makeRadiusOfView:self.openBtn];
    [self makeRadiusOfView:self.giftBtn];
    
    // 设置头像边框
    self.iconImage.layer.borderWidth = 1;
    self.iconImage.layer.borderColor = [UIColor whiteColor].CGColor;
    
    // 设置按钮
    [self.openBtn setBackgroundImage:[UIImage imageWithColor:KeyColor size:self.openBtn.xj_size]forState:UIControlStateNormal];
    [self.openBtn setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor] size:self.openBtn.xj_size]forState:UIControlStateSelected];
    // 默认关闭
    [self openOrCloseBtn:self.openBtn];
}

- (NSArray *)audienceArray{
    if (!_audienceArray) {
        NSArray *array = [NSArray mj_objectArrayWithFile:[[NSBundle mainBundle] pathForResource:@"user.plist" ofType:nil]];
        _audienceArray = [XJUserModel mj_objectArrayWithKeyValuesArray:array];
    }
    return _audienceArray;
}

// 设置圆角
- (void)makeRadiusOfView:(UIView *)view{
    view.layer.cornerRadius = view.xj_height * 0.5;
    // 裁剪
    view.layer.masksToBounds = YES;
}

// 开启或关闭按钮
- (IBAction)openOrCloseBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
}

-(void)setLive:(XJLiveModel *)live{
    _live = live;
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    self.nameLabel.text = live.myname;
    self.seeNumLabel.text = [NSString stringWithFormat:@"%ld人观看",live.allnum];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateNum) userInfo:nil repeats:YES];
    // 添加手势
    [self.iconImage addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickIocnImage:)]];
    self.iconImage.userInteractionEnabled = YES;
}

// 设置观众的Scrollview
- (void)setupAudience{
    self.peopleScrollView.contentSize = CGSizeMake((self.peopleScrollView.xj_height + Space10) * self.audienceArray.count + Space10, 0);
    CGFloat wh = self.peopleScrollView.xj_height - Space10;
    CGFloat x = 0;
    for (int i = 0; i < self.audienceArray.count; i++) {
        x = (wh + Space10) * i;
        UIImageView *audienceView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 5, wh, wh)];
        audienceView.layer.cornerRadius = wh * 0.5;
        audienceView.layer.masksToBounds = YES;
        // 取出模型
        XJUserModel *user = self.audienceArray[i];
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:user.photo] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            // 回到主线程 刷新图片
            dispatch_async(dispatch_get_main_queue(), ^{
                audienceView.image = [UIImage circleImage:image borderColor:[UIColor whiteColor] borderWidth:1];
            });
        }];
        // 设置监听
        audienceView.userInteractionEnabled = YES;
        [audienceView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(clickIocnImage:)]];
        // 标记
        audienceView.tag = i;
        // 添加到scrollview
        [self.peopleScrollView addSubview:audienceView];
    };
}

// 点击头像触发的手势
- (void)clickIocnImage:(UIGestureRecognizer *)tap{
    if (tap.view == self.iconImage) {
        XJUserModel *user = [[XJUserModel alloc] init];
        user.nickname = self.live.myname;
        user.photo = self.live.bigpic;
        // 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : user}];
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotifyClickUser object:nil userInfo:@{@"user" : self.audienceArray[tap.view.tag]}];
    }
}

// 更新人数
- (void)updateNum{
    
    randomNum += arc4random_uniform(5);
    self.seeNumLabel.text = [NSString stringWithFormat:@"%ld人", self.live.allnum + randomNum];
    [self.giftBtn setTitle:[NSString stringWithFormat:@"猫粮:%u  娃娃%u", 1993045 + randomNum,  124593+randomNum] forState:UIControlStateNormal];
}

@end
