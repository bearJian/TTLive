//
//  XJMeViewController.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJMeViewController.h"

@interface XJMeViewController ()
//@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XJMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor whiteColor];
//     隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    // 清掉每一组间的距离
    self.tableView.sectionFooterHeight = 20;
    self.tableView.sectionHeaderHeight = 0;
     // 设置额外滚动区域: tabelview额外滚动区域
    self.tableView.contentInset = UIEdgeInsetsMake(-59, 0, 0, 0);
}



@end
