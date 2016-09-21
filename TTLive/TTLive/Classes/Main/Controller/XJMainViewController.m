//
//  XJMainViewController.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJMainViewController.h"
#import "XJNavigationController.h"
#import "XJHomeViewController.h"
#import "XJMeViewController.h"
#import "XJShowTimeViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface XJMainViewController ()<UITabBarControllerDelegate>

@end

@implementation XJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    self.delegate = self;
    // 布局控件
    [self setup];
}

#pragma mark - 布局控件
- (void)setup{
    
    [self addChildViewController:[[XJHomeViewController alloc] init] imageName:@"toolbar_home"];
    
    [self addChildViewController:[[XJShowTimeViewController alloc] init] imageName:@"toolbar_live"];
    
    [self addChildViewController:[[XJMeViewController alloc] init] imageName:@"toolbar_me"];
}

// 添加子控制器
- (void)addChildViewController:(UIViewController *)childController imageName:(NSString *)imageName{
    XJNavigationController *nav = [[XJNavigationController alloc] initWithRootViewController:childController];
    // 设置tabBarItem
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_sel", imageName]];
    // 设置图片居中
    childController.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    
    [self addChildViewController: nav];
}

#pragma mark - 代理方法
// 切换TabBar并触发shouldSelectViewControlle
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([tabBarController.childViewControllers indexOfObject:viewController] == tabBarController.childViewControllers.count-2) {
        // 判断是否是模拟器
        if ([[UIDevice deviceVersion] isEqualToString:@"iPhone Simulator"]) {
            [self showInfo:@"请用真机进行测试, 此模块不支持模拟器测试"];
            return NO;
        }
        
        // 判断是否有摄像头
        if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
            [self showInfo:@"您的设备没有摄像头或者相关的驱动, 不能进行直播"];
            return NO;
        }
        
        // 判断是否有摄像头权限
        AVAuthorizationStatus  authorizationStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        if (authorizationStatus == AVAuthorizationStatusRestricted|| authorizationStatus == AVAuthorizationStatusDenied) {
            [self showInfo:@"app需要访问您的摄像头。\n请启用摄像头-设置/隐私/摄像头"];
            return NO;
        }
        
        // 开启麦克风权限
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        if ([audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
            [audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
                if (granted) {
                    return YES;
                }
                else {
                    [self showInfo:@"app需要访问您的麦克风。\n请启用麦克风-设置/隐私/麦克风"];
                    return NO;
                }
            }];
        }
        
        XJShowTimeViewController *showTimeVc = [UIStoryboard storyboardWithName:NSStringFromClass([XJShowTimeViewController class]) bundle:nil].instantiateInitialViewController;
        [self presentViewController:showTimeVc animated:YES completion:nil];
        return NO;
    }
    return YES;
}

// 弹窗提醒
- (void)showInfo:(NSString *)info
{
    if ([self isKindOfClass:[UIViewController class]] || [self isKindOfClass:[UIView class]]) {
        [[[UIAlertView alloc] initWithTitle:@"TTLive" message:info delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}


@end
