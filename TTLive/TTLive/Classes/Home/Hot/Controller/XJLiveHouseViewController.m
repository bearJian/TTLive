//
//  XJLiveHouseViewController.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJLiveHouseViewController.h"
#import "XJUserModel.h"
#import "XJHouseLiveCell.h"
#import "XJFlowLayout.h"

@interface XJLiveHouseViewController ()

@end

@implementation XJLiveHouseViewController

static NSString * const reuseIdentifier = @"XJHouseLiveCell";
-(instancetype)init{
    
    return [super initWithCollectionViewLayout:[[XJFlowLayout alloc] init]];
}

-(void)dealloc{
    NSLog(@"直播间销毁了---------------");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景
    self.view.backgroundColor = [UIColor redColor];
    
    // Register cell classes
    [self.collectionView registerClass:[XJHouseLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
}

- (void)clickUser:(NSNotification *)notify
{
//    if (notify.userInfo[@"user"] != nil) {
//        ALinUser *user = notify.userInfo[@"user"];
//        self.userView.user = user;
//        [UIView animateWithDuration:0.5 animations:^{
//            self.userView.transform = CGAffineTransformIdentity;
//        }];
//    }
    [MBProgressHUD showText:@"点击了观众"];
}

#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XJHouseLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.parentVc = self;
    cell.live = self.lives[self.currentIndex];
    cell.previewLive = self.lives[self.currentIndex + 1];
    __weak typeof(self)weakSelf = self;
    [cell setClickPreviewLiveBlock:^{
        weakSelf.currentIndex++;
        [weakSelf.collectionView reloadData];
    }];
    
    return cell;
}

@end
