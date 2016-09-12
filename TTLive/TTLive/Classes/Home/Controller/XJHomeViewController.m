//
//  XJHomeViewController.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHomeViewController.h"
#import "XJTopView.h"
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
    
    // 添加子视图
    CGFloat height = XJScreenH - 49; // 底部tabBar高为49
    // 热门
    UIViewController *hot = [[UIViewController alloc] init];
    hot.view.frame = [UIScreen mainScreen].bounds;
    hot.view.xj_height = height;
    hot.view.backgroundColor = [UIColor yellowColor];
    [self addChildViewController:hot];
    [self.view addSubview:hot.view];
    
    // 最新
    UIViewController *new = [[UIViewController alloc] init];
    new.view.frame = [UIScreen mainScreen].bounds;
    new.view.xj_x = XJScreenW;
    new.view.xj_height = height;
    new.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController:new];
    [self.view addSubview:new.view];
    
    // 关注
    UIViewController *care = [[UIViewController alloc] init];
    care.view.frame = [UIScreen mainScreen].bounds;
    care.view.xj_x = XJScreenW * 2;
    care.view.xj_height = height;
    care.view.backgroundColor = [UIColor redColor];
    [self addChildViewController:care];
    [self.view addSubview:care.view];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 基本设置
    [self setup];
}

- (void)setup{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"search_15x14"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"head_crown_24x24"] style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick)];
    
    // 设置顶部视图
    [self setupTopView];
}

-(void)rightItemClick{
    
}

// 设置顶部视图
- (void)setupTopView{
    XJTopView *topView = [[XJTopView alloc] initWithFrame:self.navigationController.navigationBar.bounds];
    CGFloat space = 30; // 间距
    topView.xj_x = space;
    topView.xj_width = XJScreenW - space * 2;
    [self.navigationController.navigationBar addSubview:topView];
    [topView setSelectBlock:^(topType type) {
        [self.scrollView setContentOffset:CGPointMake(type * XJScreenW, 0) animated:YES];
    }];
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
