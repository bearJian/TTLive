//
//  XJLiveHouseViewController.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJLiveHouseViewController.h"
#import "XJHouseLiveCell.h"
#import "XJFlowLayout.h"
#import "XJRefreshGifHeader.h"
#import "XJUserView.h"
#import "XJUserModel.h"
@interface XJLiveHouseViewController ()
/** 用户信息 */
@property (nonatomic, weak) XJUserView *userView;
@end

@implementation XJLiveHouseViewController

static NSString * const reuseIdentifier = @"XJHouseLiveCell";
-(instancetype)init{
    
    return [super initWithCollectionViewLayout:[[XJFlowLayout alloc] init]];
}

-(void)dealloc{
    NSLog(@"直播间销毁了---------------");
}

- (XJUserView *)userView
{
    if (!_userView) {
        XJUserView *userView = [XJUserView userView];
        [self.collectionView addSubview:userView];
        _userView = userView;
        
        [userView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(@0);
            make.width.equalTo(@(XJScreenW));
            make.height.equalTo(@(XJScreenH));
        }];
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        __weak typeof(self) weakSelf = self;
        [userView setCloseBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                weakSelf.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [weakSelf.userView removeFromSuperview];
                weakSelf.userView = nil;
            }];
        }];
        
    }
    return _userView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // Register cell classes
    [self.collectionView registerClass:[XJHouseLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
    
    // 刷新设置
    __weak typeof(self)weakSelf = self;
    XJRefreshGifHeader *header = [XJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentIndex++;
        if (weakSelf.currentIndex == weakSelf.lives.count) {
            weakSelf.currentIndex = 0;
        }
        // 切换时,移除
        [self.userView removeFromSuperview];
        self.userView = nil;
        
        [weakSelf.collectionView.mj_header endRefreshing];
        [weakSelf.collectionView reloadData];
    }];
    // 显示状态
    header.stateLabel.hidden = NO;
    // 设置刷新的title
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateIdle];
    [header setTitle:@"下拉切换另一个主播" forState:MJRefreshStateRefreshing];
    
    self.collectionView.mj_header = header;
    
}

- (void)clickUser:(NSNotification *)notify
{
    if (notify.userInfo[@"user"] != nil) {
        XJUserModel *userModel = notify.userInfo[@"user"];
        self.userView.user = userModel;
        [UIView animateWithDuration:0.5 animations:^{
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    XJHouseLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.parentVc = self;
    cell.live = self.lives[self.currentIndex];
    NSLog(@"self.currentIndex%ld",self.currentIndex);
    NSUInteger index = self.currentIndex;
    if (self.currentIndex + 1 == self.lives.count) { // 最后一个直播间,预览为第一个直播间
        index = 0;
    }else{
        index ++;
    }
    cell.previewLive = self.lives[index];
    
    __weak typeof(self)weakSelf = self;
    [cell setClickPreviewLiveBlock:^{
        weakSelf.currentIndex++;
        [weakSelf.collectionView reloadData];
    }];

    return cell;
}


@end
