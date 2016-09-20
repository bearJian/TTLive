//
//  XJNewStarFlowLayout.m
//  TTLive
//
//  Created by Dear on 16/9/20.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJNewStarFlowLayout.h"
static int count = 3;
@implementation XJNewStarFlowLayout
- (void)prepareLayout{
    [super prepareLayout];
    // 滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat wh = (XJScreenW - 6) / count;
    self.itemSize = CGSizeMake(wh, wh);
    
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
}
@end
