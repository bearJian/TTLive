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
#import "XJRefreshGifHeader.h"

static NSString *IDHotCell = @"XJHotLiveCell";
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
    // 刷新设置
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [XJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.currentPage = 1;
        // 加载最新数据时每次只显示一组
        weakSelf.liveArray = [NSMutableArray array];
        // 加载数据
        [weakSelf getHotLiveData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        weakSelf.currentPage++;
        // 加载数据
        [weakSelf getHotLiveData];
    }];
    // 刷新
    [self.tableView.mj_header beginRefreshing];
    // 分割线设置
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

// 获取数据
- (void)getHotLiveData{
    
    [[XJNetworkingTool shareTool] GET:[NSString stringWithFormat:@"http://live.9158.com/Fans/GetHotLive?page=%ld",self.currentPage] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        // 数据转模型
        NSArray *array = [XJLiveModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
//        NSLog(@"array+++++++++++:%@",responseObject);
        if (array.count) {
            [self.liveArray addObjectsFromArray:array];
            // 刷新A
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showText:@"暂时没有更多最新数据"];
            // 恢复当前页
            self.currentPage--;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
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

    return 465;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XJHotLiveCell *cell = [tableView dequeueReusableCellWithIdentifier:IDHotCell forIndexPath:indexPath];
//    // 注意：一定要记得移除之前添加到cell上子控制器
    
//    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    if (self.liveArray.count) {
        XJLiveModel *live = self.liveArray[indexPath.row];
        cell.live = live;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    // 直播间
    XJLiveHouseViewController *liveHouse = [[XJLiveHouseViewController alloc] init];
    // 赋值
    liveHouse.lives = self.liveArray;
    liveHouse.currentIndex = indexPath.row;
    
    [self presentViewController:liveHouse animated:YES completion:nil];
}

@end
