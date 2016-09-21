//
//  XJNewStarViewController.m
//  TTLive
//
//  Created by Dear on 16/9/20.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJNewStarViewController.h"
#import "XJNewStarFlowLayout.h"
#import "XJNewStarCell.h"
#import "XJRefreshGifHeader.h"
#import "XJUserModel.h"
#import "XJLiveModel.h"
#import "XJLiveHouseViewController.h"
@interface XJNewStarViewController ()
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
/** 最新主播列表 */
@property(nonatomic, strong) NSMutableArray *starList;
/** NSTimer */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation XJNewStarViewController

static NSString * const reuseIdentifier = @"NewStarCell";

-(instancetype)init{
    return [super initWithCollectionViewLayout:[[XJNewStarFlowLayout alloc] init]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XJNewStarCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    [self setup];
}

- (NSMutableArray *)starList{
    
    if (!_starList) {
        NSMutableArray *array = [NSMutableArray array];
        _starList = array;
    }
    return _starList;
}

- (void)setup{
    
    // 当前页 为1
    self.currentPage = 1;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 刷新设置
    __weak typeof(self) weakSelf = self;
    self.collectionView.mj_header = [XJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        
        [weakSelf getStarList];
    }];
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        [weakSelf getStarList];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

- (void)getStarList{
    [[XJNetworkingTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Room/GetNewRoomOnline?page=%ld", self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        NSString *msg = responseObject[@"msg"];
        if ([msg isEqualToString:@"fail"]) { // 数据已经加载完毕, 没有更多数据了
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
            // 弹窗
            [MBProgressHUD showText:@"暂时没有更多的数据"];
        }else{
            NSArray *arry = responseObject[@"data"][@"list"];
            [arry writeToFile:@"/Users/dear/Desktop/user.plist" atomically:YES];
            // 数组转模型
           NSArray *resule = [XJUserModel mj_objectArrayWithKeyValuesArray:arry];
            if (resule.count) {
                [self.starList addObjectsFromArray:resule];
                // 刷新
                [self.collectionView reloadData];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        self.currentPage--;
        [MBProgressHUD showText:@"网络异常"];
    }];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.starList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XJNewStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.user = self.starList[indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //创建房间
    XJLiveHouseViewController *liveHouseVC = [[XJLiveHouseViewController alloc] init];
    // 取出模型
    NSMutableArray *array = [NSMutableArray array];
    for (XJUserModel *user in self.starList) {
        XJLiveModel *liveModel = [[XJLiveModel alloc] init];
        liveModel.bigpic = user.photo;
        liveModel.smallpic = user.photo;
        liveModel.gps = user.position;
        liveModel.myname = user.nickname;
        liveModel.flv = user.flv;
        liveModel.allnum = arc4random_uniform(3000) + 300;
        liveModel.useridx = user.useridx;
        [array addObject:liveModel];
    }
    // 赋值直播间
    liveHouseVC.lives = array;
    liveHouseVC.currentIndex = indexPath.item;
    
    [self presentViewController:liveHouseVC animated:YES completion:nil];
}

@end
