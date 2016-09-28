//
//  XJCareViewController.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCareViewController.h"
#import "XJCareFlowLayout.h"
#import "XJNewStarCell.h"
#import "XJCareData.h"
#import "XJCareCoverView.h"
#import "XJUserModel.h"
#import "XJLiveModel.h"
#import "XJLiveHouseViewController.h"
@interface XJCareViewController ()

@property (nonatomic, weak) XJCareCoverView *coverView;
@property (nonatomic, strong) NSMutableArray *allModels;

@end

static NSString *reuseID = @"cell";

@implementation XJCareViewController

-(instancetype)init{
    return [super initWithCollectionViewLayout:[[XJCareFlowLayout alloc] init]];
}

- (XJCareCoverView *)coverView
{
    if (_coverView == nil){
        
        XJCareCoverView *cover = [XJCareCoverView coverView];
        
//        cover.contentMode = UIViewContentModeScaleToFill;
        cover.frame = self.collectionView.bounds;
        [self.view insertSubview:cover aboveSubview:self.collectionView];
        _coverView = cover;
    }
    return _coverView;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.allModels = [XJCareData shareCareData].allModels;
    [self.collectionView reloadData];
}

- (NSMutableArray *)allModels
{
    if (_allModels == nil){
        _allModels = [NSMutableArray arrayWithArray:[XJCareData shareCareData].allModels];
    }
    return _allModels;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 背景色
    self.collectionView.backgroundColor = [UIColor whiteColor];
    // 注册
    [self.collectionView registerNib:[UINib nibWithNibName:@"XJNewStarCell" bundle:nil] forCellWithReuseIdentifier:reuseID];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.coverView.hidden = self.allModels.count != 0;
    return self.allModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XJNewStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseID forIndexPath:indexPath];
    
    cell.layer.cornerRadius = 20;
    cell.layer.masksToBounds = YES;
    
    cell.user = self.allModels[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    XJLiveHouseViewController *userLive = [[XJLiveHouseViewController alloc] init];
    NSMutableArray *array = [NSMutableArray array];
    for (XJUserModel *userModel in self.allModels) {
        XJLiveModel *live = [[XJLiveModel alloc] init];
        live.flv = userModel.flv;
        live.bigpic = userModel.photo;
        live.smallpic = userModel.photo;
        live.gps = userModel.position;
        live.myname = userModel.nickname;
        live.allnum = arc4random_uniform(3000) + 300;
        live.useridx = userModel.useridx;
        [array addObject:live];
    }
    userLive.lives = array;
    __block NSInteger currentIndex = 0;
    [userLive setIndexBlock:^(NSInteger index) {
        currentIndex = index;
    }];
    userLive.currentIndex = currentIndex;
    
    [self presentViewController:userLive animated:YES completion:nil];
}

@end
