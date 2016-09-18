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


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置背景
    self.view.backgroundColor = [UIColor redColor];
    
    // Register cell classes
    [self.collectionView registerClass:[XJHouseLiveCell class] forCellWithReuseIdentifier:reuseIdentifier];
}



#pragma mark <UICollectionViewDataSource>


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XJHouseLiveCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    cell.live = self.lives[self.currentIndex];
    
    return cell;
}

@end
