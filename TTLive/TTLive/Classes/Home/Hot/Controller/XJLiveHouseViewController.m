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
#import "XJRefreshGifHeader.h"
#import "XJUserView.h"

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
        [userView setCloseBlock:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                [self.userView removeFromSuperview];
                self.userView = nil;
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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotifyClickUser object:nil];
    
    // 刷新设置
    __weak typeof(self)weakSelf = self;
    XJRefreshGifHeader *header = [XJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentIndex++;
        if (weakSelf.currentIndex == weakSelf.lives.count) {
            weakSelf.currentIndex = 0;
        }
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
        XJUserModel *user = notify.userInfo[@"user"];
        self.userView.user = user;
        [self.userView getUserModal:user];
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
    
    NSUInteger index = self.currentIndex;
    if (self.currentIndex == self.lives.count) {
        index = 0;
    }else{
        index += 1;
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
