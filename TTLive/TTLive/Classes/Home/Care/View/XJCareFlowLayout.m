//
//  XJCareFlowLayout.m
//  TTLive
//
//  Created by Dear on 16/9/28.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJCareFlowLayout.h"

static int count = 2;
static CGFloat margin = 10;
@implementation XJCareFlowLayout

- (void)prepareLayout{
    [super prepareLayout];
    // 滚动方向
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    CGFloat wh = (XJScreenW - margin * 3) / count;
    self.itemSize = CGSizeMake(wh, wh);
    
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.alwaysBounceVertical = YES;
    
    self.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin);
}
@end
