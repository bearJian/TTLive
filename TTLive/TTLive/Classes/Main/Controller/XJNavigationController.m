//
//  XJNavigationController.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJNavigationController.h"

@interface XJNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation XJNavigationController

+ (void)initialize
{
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navBar_bg_414x70"] forBarMetrics:UIBarMetricsDefault];
}

+(void)load{
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条标题
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = [UIColor whiteColor];
    bar.titleTextAttributes = attr;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
//    // 添加Pan,全屏
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
//    [self.view addGestureRecognizer:pan];
//    
//    // 不允许边缘手势触发
//    self.interactivePopGestureRecognizer.enabled = NO;
//    
//    // 实现滑动返回功能
//    pan.delegate = self;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    // 在根控制器下，就不需要滑动手势，返回NO
//    return self.childViewControllers.count > 1;
//}

// 设置跳转
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count) {
        // 隐藏导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 自定义返回按钮
        UIButton *backBtn = [[UIButton alloc] init];
        [backBtn setImage:[UIImage imageNamed:@"back_9x16"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [backBtn sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        if ([viewController isKindOfClass:[NSClassFromString(@"XJSearchViewController") class]]) {
            [backBtn setHidden:YES];
        }
    }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    // 判断两种情况: push 和 present
    if ((self.presentedViewController || self.presentingViewController) && self.childViewControllers.count == 1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
        [self popViewControllerAnimated:YES];
}

@end
