//
//  XJHotViewController.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHotViewController.h"

static NSString *reuseIdentifier = @"XJHotLiveCell";
static NSString *ADReuseIdentifier = @"XJHomeADCell";
@interface XJHotViewController ()
/**直播用户组*/
@property (nonatomic, strong) NSMutableArray *liveArray;

@end

@implementation XJHotViewController

#pragma mark - 懒加载
- (NSMutableArray *)liveArray{
    if (!_liveArray) {
        _liveArray = [NSMutableArray array];
    }
    return _liveArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XJHotViewController class]) bundle:nil] forCellReuseIdentifier:reuseIdentifier];
    
}



#pragma mark - Table view data source

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return 20;
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    
//    return cell;
//}


@end
