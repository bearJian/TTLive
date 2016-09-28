//
//  XJHomeViewController.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHomeViewController.h"
#import "XJCareViewController.h"
#import "XJHotViewController.h"
#import "XJTopView.h"
#import "XJNewStarViewController.h"
#import "XJSearchViewController.h"
// 标题个数
static int count = 3;
@interface XJHomeViewController ()<UIScrollViewDelegate>
/** 顶部选择视图 */
@property(nonatomic, assign) XJTopView *topView;
/**UIScrollView*/
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation XJHomeViewController

- (void)loadView{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置
    scrollView.contentSize = CGSizeMake(XJScreenW * count, 0);
    scrollView.backgroundColor = [UIColor whiteColor];
    // 去掉滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置分页
    scrollView.pagingEnabled = YES;
    // 设置代理
    scrollView.delegate = self;
    // 赋值
    self.view = scrollView;
    _scrollView = scrollView;
    
    // 添加子视图
    CGFloat height = XJScreenH - 49; // 底部tabBar高为49
    // 热门
    XJHotViewController *hot = [[XJHotViewController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.xj_height = height;
    [self addChildViewController:hot];
    [self.view addSubview:hot.view];
    
    // 最新
    XJNewStarViewController *new = [[XJNewStarViewController alloc] init];
    new.view.frame = [UIScreen mainScreen].bounds;
    new.view.xj_x = XJScreenW;
    new.view.xj_height = height;
    [self addChildViewController:new];
    [self.view addSubview:new.view];
    
    // 关注
    XJCareViewController *care = [[XJCareViewController alloc] init];
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.xj_x = XJScreenW * 2;
    care.view.xj_height = height;
    [self addChildViewController:care];
    [self.view addSubview:care.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 基本设置
    [self setup];
}

- (void)setup{
    // 搜索
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    
    // 设置顶部视图
    [self setupTopView];
}

- (void)leftItemClick{
    // 移除顶部子控件
    [_topView removeFromSuperview];
    _topView = nil;
    XJSearchViewController *searchVC = [[XJSearchViewController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
 }

-(void)rightItemClick{
    
    UIViewController *webView = [[UIViewController alloc] init];
    UIWebView *web = [[UIWebView alloc] init];
    webView.view = web;
    NSURL *url = [NSURL URLWithString:@"http://live.9158.com/Rank/WeekRank?Random=10"];
    [web loadRequest:[NSURLRequest requestWithURL:url]];

    [webView.navigationItem setTitle:@"周消费榜"];
    [_topView removeFromSuperview];
    _topView = nil;
    [self.navigationController pushViewController:webView animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!_topView) {
        [self setupTopView];
    }
}


// 设置顶部视图
- (void)setupTopView{
    XJTopView *topView = [[XJTopView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    CGFloat space = 40; // 间距
    topView.xj_x = space;
    topView.xj_width = XJScreenW - space * 2;
    __weak typeof(self) weakSelf = self;
    [topView setSelectBlock:^(topType type) {
        [weakSelf.scrollView setContentOffset:CGPointMake(type * XJScreenW, 0) animated:YES];
    }];
    [self.navigationController.navigationBar addSubview:topView];
    self.topView = topView;
}


#pragma mark - 代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int page = scrollView.contentOffset.x / XJScreenW + 0.5;
    CGFloat offsetX = scrollView.contentOffset.x / XJScreenW * (self.topView.xj_width * 0.5 - TopViewW * 0.5 - 20);
    self.topView.line.xj_x = offsetX + 20;
    
    self.topView.selectBtnType = page;
}
@end
