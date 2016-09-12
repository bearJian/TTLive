//
//  XJLoginViewController.m
//  TTLive
//
//  Created by Dear on 16/9/9.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJLoginViewController.h"
#import "XJMainViewController.h"
@interface XJLoginViewController ()
/**player*/
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
/**快速入口*/
@property (nonatomic, weak) UIButton *quickBtn;
/**封面图片*/
@property (nonatomic, weak) UIImageView *imageView;
@end

@implementation XJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUp];
}

#pragma mark - 懒加载
// 使用ijkplayer来播放
- (IJKFFMoviePlayerController *)player{
    
    if (!_player) {
        // 随机播放一组视频
        NSString *path = arc4random_uniform(10) % 2 ? @"login_video" : @"loginmovie";
        // 创建,并设置数据源
        IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@"mp4" ] withOptions:[IJKFFOptions optionsByDefault]];
        // 设置player
        player.view.frame = self.view.bounds;
        // 设置缩放比例
        player.scalingMode = IJKMPMovieScalingModeAspectFill;
        // 设置自动播放
        player.shouldAutoplay = NO;
        // 准备播放
        [player prepareToPlay];
        // 添加到view
        [self.view addSubview:player.view];
        
        _player = player;
    }
    return _player;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        UIImageView *image = [[UIImageView alloc] initWithFrame:self.view.bounds];
        image.image = [UIImage imageNamed:@"LaunchImage"];
        [self.player.view addSubview:image];
        _imageView = image;
    }
    return _imageView;
}

- (UIButton *)quickBtn{
    if (!_quickBtn) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor clearColor];
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = [UIColor greenColor].CGColor;
        [btn setTitle:@"快速入口" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        // 添加监听
        [btn addTarget:self action:@selector(quickLogIn) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        btn.hidden = YES;
        _quickBtn = btn;
    }
    return _quickBtn;
}

#pragma mark - 方法
// 快速进入
- (void)quickLogIn{
    // 提示
    [MBProgressHUD showText:@"登陆成功"];
    
    // 延时1秒登录
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 跳转到主界面
        [self presentViewController:[[XJMainViewController alloc] init] animated:NO completion:^{
            // 停止播放
            [self.player stop];
            // 移除
            [self.player.view removeFromSuperview];
            self.player = nil;
        }];
    });
}

// 创建子控件
- (void)setUp{
    
    [self initObserver];
    
    self.imageView.hidden = NO;
    
    [self.quickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@40);
        make.right.equalTo(@-40);
        make.bottom.equalTo(@-60);
        make.height.equalTo(@40);
    }];
}

// 监听视频是否播放完成
- (void)initObserver{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:nil];
    // 监听加载状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:nil];
}

// 播放结束
- (void)playerFinish{
    // 播放完后,再重播
    [self.player play];
}

// 加载状态改变时调用
- (void)stateDidChange{
    
    if ((self.player.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        // 没有播放时 加载封面
        if (!self.player.isPlaying) {
            self.imageView.frame = self.view.bounds;
            [self.view insertSubview:self.imageView atIndex:0];
            [self.player play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.quickBtn.hidden = NO;
            });
        }
    }
}

#pragma mark - 控制器生命周期
// 视图即将消失、被覆盖或是隐藏时调用
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    // 暂停
    [self.player shutdown];
    // 移除监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 视图已经消失、被覆盖或是隐藏时调用
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.player.view removeFromSuperview];
    self.player = nil;
}

-(void)dealloc{
    NSLog(@"登录界面销毁");
}

@end
