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
#import "XJHousePreviewView.h"

@interface XJHouseLiveCell()
/**主播顶部栏*/
@property (nonatomic, weak) XJHouseTopView *topView;
/** 底部的工具栏 */
@property(nonatomic, weak) XJHouseBottomView *toolView;
/**直播开始前的占位图片*/
@property(nonatomic, weak) UIImageView *placeholderView;
/** 直播播放器 */
@property (nonatomic, strong) IJKFFMoviePlayerController *moviePlayer;
/**粒子融器*/
@property (nonatomic, weak) CAEmitterLayer *emitterLayer;
/**关联的主播*/
@property (nonatomic, weak) UIImageView *associateView;
/**直播预览View*/
@property (nonatomic, weak) XJHousePreviewView *previewView;

@end

@implementation XJHouseLiveCell

#pragma mark - 懒加载

- (XJHousePreviewView *)previewView{
    
    if (!_previewView) {
        XJHousePreviewView *preview = [XJHousePreviewView allocWithNib];
        // 添加手势
        [preview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickPreview:)]];
        // 设置位置
        [self.moviePlayer.view addSubview:preview];
        [preview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-20);
            make.centerY.equalTo(self.moviePlayer.view);
            make.width.height.equalTo(@100);
        }];
        _previewView = preview;
    }
    return _previewView;
}

- (UIImageView *)associateView{
    
    if (!_associateView) {
        UIImageView *associate = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"private_icon_70x70"]];
        // 设置交互
        associate.userInteractionEnabled = YES;
        // 添加点按手势
        [associate addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAssociateView:)]];
        
        [self.contentView insertSubview:associate aboveSubview:self.placeholderView];
        [associate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@-10);
            make.width.height.equalTo(@60);
            make.top.equalTo(@(XJScreenH * 0.35));
        }];
        _associateView = associate;
    }
    
    return _associateView;
}

- (CAEmitterLayer *)emitterLayer{
    
    if (!_emitterLayer) {
        // 创建粒子容器
        CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc] init];
        // 设置发射位置
        emitterLayer.emitterPosition = CGPointMake(self.moviePlayer.view.xj_width - 50, self.moviePlayer.view.xj_height - 50);
        // 设置尺寸大小
        emitterLayer.emitterSize = CGSizeMake(20, 20);
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered;
        // 开启三维效果
        emitterLayer.preservesDepth = YES;
        // 创建粒子
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            // 粒子
            CAEmitterCell *imgCell = [[CAEmitterCell alloc] init];
            // 粒子的创建速率,默认为1/s
            imgCell.birthRate = 1;
            // 粒子的存活时间
            imgCell.lifetime = arc4random_uniform(3) + 1;
            // 粒子的生存时间容差
            imgCell.lifetimeRange = 1.5;
            // 设置内容
            imgCell.contents = (id)[UIImage imageNamed:[NSString stringWithFormat:@"good%d_30x30",i]].CGImage;
            // 粒子的运动速率
            imgCell.velocity = arc4random_uniform(100) + 100;
            // 粒子速度的容差
            imgCell.velocityRange = 80;
            // 粒子的发射角度
            imgCell.emissionLongitude = -M_PI_2;
            // 粒子发射角度的容差
            imgCell.emissionRange = M_PI_2 / 6;
            // 粒子的缩放比例
            imgCell.scale = 0.3;
            // 添加到数组
            [array addObject:imgCell];
        }
        // 加到粒子容器
        emitterLayer.emitterCells = array;
        // 将粒子容器加入到view
        [self.moviePlayer.view.layer insertSublayer:emitterLayer below:self.toolView.layer];
        _emitterLayer = emitterLayer;
    }
    return  _emitterLayer;
}

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
        __weak typeof(self)weakSelf = self;
        [topView setClickOpenBtnBlock:^(bool selected) {
            if (selected == NO) {
                [weakSelf.previewView show];
            }else{
                [weakSelf.previewView hide];
            }
        }];
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
        __weak typeof(self)weakSelf = self;
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
                    [weakSelf share];
                    break;
                case LiveToolTypeClose:
                    [weakSelf close];
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

#pragma mark - 方法

-(void)setPreviewLive:(XJUserModel *)previewLive{
    
    _previewLive = previewLive;
    if (previewLive) {
        self.previewView.live = previewLive;
    }else{
        self.previewView.hidden = YES;
    }
}

- (void)clickPreview:(UITapGestureRecognizer *)tap{
    
    if (self.clickPreviewLiveBlock) {
        self.clickPreviewLiveBlock();
    }
}

- (void)clickAssociateView:(UITapGestureRecognizer *)tap{
    
    [MBProgressHUD showText:@"暂未完善"];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.toolView.hidden = NO;
    }
    return  self;
}

-(void)setLive:(XJLiveModel *)live{
    _live = live;
    self.topView.scrollText = nil;
    self.topView.live = live;
    [self playerFLV:live.flv placehplderUrl:live.bigpic];
}

- ( void)playerFLV:(NSString *)flv placehplderUrl:(NSString *)placehplderUrl{
    
    if (_moviePlayer) {
        if (_moviePlayer) {
            // 将站位图片插入到播放器上面
            [self.contentView insertSubview:self.placeholderView aboveSubview:_moviePlayer.view];
        }
        if (_previewView) {
            // 保持开启状态
            [self.topView keepSelectState];
            [_previewView removeFromSuperview];
            _previewView = nil;
        }
        
        [_moviePlayer shutdown];
        [_moviePlayer.view removeFromSuperview];
        _moviePlayer = nil;
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    }
    // 切换主播,取消之前的动画
    if (_emitterLayer) {
        [_emitterLayer removeFromSuperlayer];
        _emitterLayer = nil;
    }
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:placehplderUrl] options:SDWebImageDownloaderUseNSURLCache progress:nil completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.parentVc showGifLoding:nil inView:self.placeholderView];
                self.placeholderView.image = [UIImage blurImage:image blur:0.8];
            });
        }];
 
    IJKFFOptions *options = [IJKFFOptions optionsByDefault];
    // 开启硬解码
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
    
    // 将关联主播加载到父视图最上层
//    [self.moviePlayer.view bringSubviewToFront:self.associateView];
    [self.associateView setHidden:NO];
    
    // 显示粒子效果
    [self.emitterLayer setHidden:NO];
    
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
                [self.parentVc hideGifLoding];
            });
        }else{
            // 如果是网络状态不好, 断开后恢复, 也需要去掉加载
            if (self.parentVc.gifView.isAnimating) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.parentVc hideGifLoding];
                });
            
            }
        }
    }else if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled){ // 网速不佳, 自动暂停状态
        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
    }
}

- (void)didFinish
{
    NSLog(@"加载状态...%ld %ld %s", self.moviePlayer.loadState, self.moviePlayer.playbackState, __func__);
    // 因为网速或者其他原因导致直播stop了, 也要显示GIF
    if (self.moviePlayer.loadState & IJKMPMovieLoadStateStalled && !self.parentVc.gifView) {
        [self.parentVc showGifLoding:nil inView:self.moviePlayer.view];
        return;
    }
//        方法：
//          1、重新获取直播地址，服务端控制是否有地址返回。
//          2、用户http请求该地址，若请求成功表示直播未结束，否则结束
    __weak typeof(self)weakSelf = self;
    [[XJNetworkingTool shareTool] GET:self.live.flv parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功%@, 等待继续播放", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败, 加载失败界面, 关闭播放器%@", error);
        [weakSelf.moviePlayer shutdown];
        [weakSelf.moviePlayer.view removeFromSuperview];
        weakSelf.moviePlayer = nil;
//        weakSelf.endView.hidden = NO;
    }];
}

- (void)close{
    if (_moviePlayer) {
        [self.moviePlayer shutdown];
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
    [self.parentVc dismissViewControllerAnimated:YES completion:nil];
}

- (void)share{

    // 获取当前房间
    XJLiveModel *house = self.topView.live;
    
    NSString *homeUrl = [NSString stringWithFormat:@"http://www.miaobolive.com/live.aspx?u_serverid=%ld&u_roomid=%ld&isappinstalled=0&roomidx=%@",house.serverid,house.roomid,house.useridx];

    NSString *str = [NSString stringWithFormat:@"%@",house.bigpic];
    [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:str];
    [UMSocialData defaultData].extConfig.title = @"我的心愿是,世界和平";
    [UMSocialData defaultData].extConfig.qqData.url = [NSString stringWithFormat:@"%@",homeUrl];
    [UMSocialData defaultData].extConfig.qzoneData.url = [NSString stringWithFormat:@"%@",homeUrl];
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = [NSString stringWithFormat:@"%@",homeUrl];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = [NSString stringWithFormat:@"%@",homeUrl];
    
    [UMSocialSnsService presentSnsIconSheetView:self.parentVc
                                         appKey:nil
                                      shareText:[NSString stringWithFormat:@"我是:%@我的心情:%@我的房间号:%@我的直播间:%@",house.myname, house.signatures,house.useridx,homeUrl]
                                     shareImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",house.bigpic]]
                                shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToSina,UMShareToQQ,UMShareToQzone,UMShareToWechatFavorite,UMShareToDouban]
                                       delegate:nil];

}


-(void)dealloc{
    NSLog(@"cell销毁了--------------");
}

@end
