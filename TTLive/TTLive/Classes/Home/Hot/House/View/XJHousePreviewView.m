//
//  XJHousePreviewView.m
//  TTLive
//
//  Created by Dear on 16/9/19.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHousePreviewView.h"
#import "XJUserModel.h"

@interface XJHousePreviewView()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *preview;
/**直播播放器*/
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
@end
@implementation XJHousePreviewView

+ (instancetype)allocWithNib{
    
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.preview.layer.cornerRadius = self.preview.xj_width * 0.5;
    self.preview.layer.masksToBounds = YES;
}

-(void)setLive:(XJUserModel *)live{
    
    _live = live;
    // 播放视频,
    IJKFFOptions *option = [IJKFFOptions optionsByDefault];
    // 不播放声音
    [option setPlayerOptionValue:@"1" forKey:@"an"];
    // 开启硬解码
    [option setPlayerOptionValue:@"1" forKey:@"videotoolbox"];
    
    IJKFFMoviePlayerController *player = [[IJKFFMoviePlayerController alloc] initWithContentURLString:live.flv withOptions:option];
    // 配置播放器
    // 尺寸
    player.view.frame = self.preview.bounds;
    // 填充fill
    player.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 自动播放
    player.shouldAutoplay = YES;
    // 准备播放
    [player prepareToPlay];
    [self.preview addSubview:player.view];
    self.moviePlayer = player;
}

// 当前视图从其父视图移除时调用
- (void)removeFromSuperview{
    
    if (_moviePlayer) {
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
    }
    [super removeFromSuperview];
}

/**显示*/
- (void)show{
    self.preview.hidden = NO;
    self.imageView.hidden = NO;
    self.userInteractionEnabled = YES;
}
/**隐藏*/
- (void)hide{
    self.preview.hidden = YES;
    self.imageView.hidden = YES;
    self.userInteractionEnabled = NO;
}

@end
