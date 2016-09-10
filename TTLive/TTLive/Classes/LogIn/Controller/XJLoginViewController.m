//
//  XJLoginViewController.m
//  TTLive
//
//  Created by Dear on 16/9/9.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJLoginViewController.h"

@interface XJLoginViewController ()
/**player*/
@property (nonatomic, strong) IJKFFMoviePlayerController *player;
@end

@implementation XJLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
}

// 懒加载
// 使用ijkplayer来播放
- (IJKFFMoviePlayerController *)player{
    
    if (!_player) {
        // 随机播放一组视频
        NSString *path = arc4random_uniform(10) & 2 ? @"login_video" : @"loginmovie";
        // 创建,并设置数据源
        _player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:[[NSBundle mainBundle] pathForResource:path ofType:@".mp4" ] withOptions:[IJKFFOptions optionsByDefault]];
        // 设置player
        _player.view.frame = self.view.bounds;
        // 设置缩放比例
        _player.scalingMode = IJKMPMovieScalingModeAspectFill;
        // 设置自动播放
        _player.shouldAutoplay = NO;
        // 准备播放
        [_player prepareToPlay ];
    }
    return _player;
}

@end
