//
//  XJLiveCell.m
//  TTLive
//
//  Created by Dear on 16/9/18.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJHouseLiveCell.h"
#import "XJHouseTopView.h"
#import "XJLiveModel.h"
#import "XJHouseBottomView.h"
@interface XJHouseLiveCell()
/**主播顶部栏*/
@property (nonatomic, strong) XJHouseTopView *topView;
/** 底部的工具栏 */
@property(nonatomic, weak) XJHouseBottomView *toolView;
/**直播开始前的占位图片*/
@property(nonatomic, weak) UIImageView *placeholderView;
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
@end

@implementation XJHouseLiveCell

- (UIImageView *)placeholderView{
    if (!_placeholderView) {
        UIImageView *img = [[UIImageView alloc] init];
        img.frame = self.contentView.bounds;
        img.image = [UIImage imageNamed:@"profile_user_414x414"];
        [self.contentView addSubview:img];
        _placeholderView = img;
        // 显示gif
        [self.parentVc showGifLoding:nil inView:self.placeholderView];
        // 强制布局
        [_placeholderView layoutIfNeeded];
    }
    return _placeholderView;
}

- (XJHouseTopView *)topView{
    
    if (!_topView) {
        XJHouseTopView *topView = [XJHouseTopView allocWithNib];
        [self.contentView insertSubview:topView aboveSubview:self.placeholderView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(@0);
            make.height.equalTo(@120);
        }];
        _topView = topView;
    }
    
    return _topView;
}

- (XJHouseBottomView *)toolView{
    if (!_toolView) {
        XJHouseBottomView *toolview = [[XJHouseBottomView alloc] init];
        [toolview setClickTollBlock:^(LiveToolType type) {
            switch (type) {
                case LiveToolTypePublicTalk:
                    [MBProgressHUD showText:@"开启弹幕"];
                    break;
                case LiveToolTypePrivateTalk:
                    break;
                case LiveToolTypeRank:
                    break;
                case LiveToolTypeGift:
                    break;
                case LiveToolTypeShare:
                    break;
                case LiveToolTypeClose:
                    [self close];
                    break;
                default:
                    break;
            }
        }];
        [self.contentView insertSubview:toolview aboveSubview:self.placeholderView];
        [toolview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(@0);
            make.bottom.equalTo(@-10);
            make.height.equalTo(@40);
        }];
        _toolView = toolview;
        
    }
    return  _toolView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.toolView.hidden = NO;
    }
    return  self;
}

-(void)setLive:(XJLiveModel *)live{
    _live = live;
    self.topView.live = live;
    [self playerFLV:live.flv placehplderUrl:live.bigpic];
}

- ( void)playerFLV:(NSString *)flv placehplderUrl:(NSString *)placehplderUrl{
    if (!_moviePlayer) {
        // 将站位图片插入到播放器上面
        [self.contentView insertSubview:self.placeholderView aboveSubview:_moviePlayer.view];
    }
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placehplderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.parentVc showGifLoding:nil inView:self.placeholderView];
            self.placeholderView.image = [UIImage blurImage:image blur:0.8];
        });
    }];
    
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    [options setPlayerOptionIntValue:1 forKey:@"videotoolbox"];
    // 帧速率
    [options setPlayerOptionIntValue:29.97 forKey:@"r"];
    // 设置音量大小 - 256为标准音量。要设置成两倍音量时则输入512，依此类推
    [options setPlayerOptionIntValue:512 forKey:@"vol"];
    
    IJKFFMoviePlayerController *moviePlayer = [[IJKFFMoviePlayerController alloc] initWithContentURLString:flv withOptions:options];
    // 设置属性
    // 尺寸
    moviePlayer.view.frame = self.contentView.bounds;
    // 填充fill
    moviePlayer.scalingMode = IJKMPMovieScalingModeAspectFill;
    // 自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态)
    moviePlayer.shouldAutoplay = NO;
    // 默认不显示
    moviePlayer.shouldShowHudView = NO;
    // 准备播放
    [moviePlayer prepareToPlay];
    
    [self.contentView insertSubview:moviePlayer.view atIndex:0];
    
    self.moviePlayer = moviePlayer;
    
    // 设置监听
    [self initObserver];
    
}

- (void)initObserver{
    // 监听视频是否播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinish) name:IJKMPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayer];
    // 
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateDidChange) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.moviePlayer];
}

- (void)stateDidChange
{
    if ((self.moviePlayer.loadState & IJKMPMovieLoadStatePlaythroughOK) != 0) {
        if (!self.moviePlayer.isPlaying) {
            [self.moviePlayer play];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_placeholderView) {
                    [_placeholderView removeFromSuperview];
                    _placeholderView = nil;
//                    [self.moviePlayer.view addSubview:_renderer.view];
                }
//                [self.parentVc hideGufLoding];
            });
//        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
//            if (self.parentVc.gifView.isAnimating) {
//                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [self.parentVc hideGufLoding];
//                });
            
//            }
        }
//    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
//        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
//    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
//        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
//        return;
//    }
    //    方法：
    //      1、重新获取直播地址，服务端控制是否有地址返回。
    //      2、用户http请求该地址，若请求成功表示直播未结束，否则结束
//    __weak typeof(self)weakSelf = self;
//    [[ALinNetworkTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"请求成功%@, 等待继续播放", responseObject);
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
//        [weakSelf.moviePlayer shutdown];
//        [weakSelf.moviePlayer.view removeFromSuperview];
//        weakSelf.moviePlayer = nil;
//        weakSelf.endView.hidden = NO;
//    }];
}

- (void)close{
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self.parentVc dismissViewControllerAnimated:YES completion:nil];
}

@end
