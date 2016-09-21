//
//  AppDelegate.m
//  TTLive
//
//  Created by Dear on 16/9/10.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "AppDelegate.h"
#import "Reachability.h"
#import "XJLoginViewController.h"
#import "XJToTopView.h"
@interface AppDelegate (){
    Reachability *_reacha;
    NetworkStates _preStatus;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setupShare];
    
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置根控制器
    self.window.rootViewController = [[XJLoginViewController alloc] init];
    // 显示窗口
    [self.window makeKeyAndVisible];
    
    [self checkNetworkStates];
    
    NSLog(@"网络状态码:------>%ld",[XJNetworkingTool getNetworkStates]);
    return YES;
}

- (void)setupShare{
    
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:@"57e202e967e58e423c00261a"];
    // 隐藏未安装的程序
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ, UMShareToQzone, UMShareToWechatSession, UMShareToWechatTimeline]];
    // 微信
    [UMSocialWechatHandler setWXAppId:@"wxb69b9ccbd6f8cfff" appSecret:@"ae2568ac8c27fccc056f3479f30e3eee" url:@"http://www.jianshu.com/users/7a29a936552d/latest_articles"];
    // QQ
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.jianshu.com/users/7a29a936552d/latest_articles"];
    // 新浪微博
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"263570835"
                                              secret:@"6fa08301a3a4f2d2dbe94c1ef002c441"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}

// 实时监控网络状态
- (void)checkNetworkStates{
    
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkChange) name:kReachabilityChangedNotification object:nil];
    
    // 网络检查
    _reacha = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    
    // 开始监听，会启动一个run loop
    [_reacha startNotifier];
}

// 网络状态改变时调用
- (void)networkChange{
    NSString *state;
    NetworkStates currentStates = [XJNetworkingTool getNetworkStates];
    if (currentStates == _preStatus) {
        return;
    }
    _preStatus = currentStates;
    switch (currentStates) {
        case NetworkStatesNone:
            state = @"当前无网络, 请检查您的网络状态";
            break;
        case NetworkStates2G:
            state = @"切换到了2G网络";
            break;
        case NetworkStates3G:
            state = @"切换到了3G网络";
            break;
        case NetworkStates4G:
            state = @"切换到了4G网络";
            break;
        case NetworkStatesWifi:
            state = nil;
            break;
        default:
            break;
    }
    
    if (state.length) {
        [[[UIAlertView alloc] initWithTitle:@"TTLive" message:state delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil] show];
    }
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}


#pragma mark - 应用开始聚焦
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 给状态栏添加一个按钮可以进行点击, 可以让屏幕上的scrollView滚到最顶部
    [XJToTopView show];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
