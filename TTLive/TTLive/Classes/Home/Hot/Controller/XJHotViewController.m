//
//  XJHotViewController.m
//  TTLive
//
//  Created by Dear on 16/9/13.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHotViewController.h"
#import "XJHotLiveCell.h"
#import "XJLiveModel.h"
#import "XJLiveHouseViewController.h"
static NSString *IDHotCell = @"XJHotLiveCell";
static NSString *IDADCell = @"XJHomeADCell";
@interface XJHotViewController ()
/**直播用户组*/
@property (nonatomic, strong) NSMutableArray *liveArray;
/** 当前页 */
@property(nonatomic, assign) NSUInteger currentPage;
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
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XJHotLiveCell class]) bundle:nil] forCellReuseIdentifier:IDHotCell];
    // 设置当前页
    self.currentPage = 1;
    // 分割线设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 加载数据
    [self getHotLiveData];
}

// 获取数据
- (void)getHotLiveData{
    [[XJNetworkingTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 数据转模型
        NSArray *array = [XJLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
        if (array.count) {
            [self.liveArray addObjectsFromArray:array];
            // 刷新
            [self.tableView reloadData];
            // 当前页
            self.currentPage--;
        }else{
            [MBProgressHUD showText:@"暂时没有更多最新数据"];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showText:@"网络异常"];
        // 当前页
        self.currentPage--;
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.liveArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath == 0) {
//        return 100;
//    }
    return 465;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath == 0) {
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDADCell];
//        return cell;
//    }
    XJHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:IDHotCell];
    if (self.liveArray.count) {
        XJLiveModel *live = self.liveArray[indexPath.row];
        cell.live = live;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    XJLiveHouseViewController *liveHouse = [[XJLiveHouseViewController alloc] init];
    
    // 赋值
    liveHouse.lives = self.liveArray;
    liveHouse.currentIndex = indexPath.row;
    
    [self presentViewController:liveHouse animated:YES completion:nil];
}

@end
