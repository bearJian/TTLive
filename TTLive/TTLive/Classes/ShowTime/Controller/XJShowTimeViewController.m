//
//  XJShowTimeViewController.m
//  TTLive
//
//  Created by Dear on 16/9/12.
//  Copyright © 2016年 Dear. All rights reserved.
//

#import "XJShowTimeViewController.h"
#import <LFLiveKit/LFLiveKit.h>
@interface XJShowTimeViewController ()<LFLiveSessionDelegate>
@property (weak, nonatomic) IBOutlet UIButton *makeBeautifulBtn;
@property (weak, nonatomic) IBOutlet UIButton *startLivingBtn;
@property (weak, nonatomic) IBOutlet UILabel *statusBtn;

/**RTMP*/
@property (nonatomic, strong) LFLiveSession *liveSession;
@property (nonatomic, weak) UIView *preView;
@property (nonatomic, copy) NSString *rtmpUrl;
@end

@implementation XJShowTimeViewController

#pragma mark - 懒加载
- (LFLiveSession *)liveSession{
    
    if (!_liveSession) {
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        _liveSession = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfigurationForQuality:LFLiveVideoQuality_Low2] captureType:LFLiveCaptureMaskAll];
        
        // 设置代理
        _liveSession.delegate = self;
        _liveSession.running = YES;
        _liveSession.preView = self.preView;
    }
    return _liveSession;
}

- (UIView *)preView{
    
    if (!_preView) {
        UIView *preview = [[UIView alloc] initWithFrame:self.view.bounds];
        preview.backgroundColor = [UIColor clearColor];
        // 自动调整子控件与父控件中间的位置,宽高
        preview.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.view insertSubview:preview atIndex:0];
        _preView = preview;
    }
    return _preView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 隐藏导航条
    self.navigationController.navigationBar.hidden = YES;
    [self setup];
}

- (void)setup{
    // 设置圆角
    self.makeBeautifulBtn.layer.cornerRadius = self.makeBeautifulBtn.xj_height * 0.5;
    self.makeBeautifulBtn.layer.masksToBounds = YES;
    
    self.statusBtn.backgroundColor = KeyColor;
    // 设置圆角
    self.startLivingBtn.layer.cornerRadius = self.startLivingBtn.xj_height * 0.5;
    self.startLivingBtn.layer.masksToBounds = YES;
    
    // 默认开始后置摄像头
    self.liveSession.captureDevicePosition = AVCaptureDevicePositionFront;
}

- (IBAction)makeBeautifulBtn:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    // 默认开启美颜
    self.liveSession.beautyFace = !self.liveSession.beautyFace;
}

- (IBAction)switchCamare:(UIButton *)sender {
    
    AVCaptureDevicePosition devicePosition = self.liveSession.captureDevicePosition;
    self.liveSession.captureDevicePosition = (devicePosition == AVCaptureDevicePositionFront) ? AVCaptureDevicePositionBack : AVCaptureDevicePositionFront;
}

- (IBAction)closeLive:(UIButton *)sender {
    // 查看连接状态
    if (self.liveSession.state == LFLivePending || self.liveSession.state == LFLiveStart) {
        [self.liveSession stopLive];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)startLiveBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) { // 开始直播
        LFLiveStreamInfo *stream = [[LFLiveStreamInfo alloc] init];
        //
        stream.url = @"rtmp://live.hkstv.hk.lxdns.com:1935/live/bear";
        self.rtmpUrl = stream.url;
        [self.liveSession startLive:stream];
    }else{ // 结束直播
        [self.liveSession stopLive];
        self.statusBtn.text = [NSString stringWithFormat:@"状态: 直播被关闭\nRTMP: %@", self.rtmpUrl];
    }
}

#pragma mark - 代理方法
// 直播状态改变时调用
-(void)liveSession:(LFLiveSession *)session liveStateDidChange:(LFLiveState)state{
    
    NSString *status;
    switch (state) {
        case LFLiveReady:
            status = @"准备中";
            break;
        case LFLivePending:
            status = @"连接中";
            break;
        case LFLiveStart:
            status = @"已连接";
            break;
        case LFLiveStop:
            status = @"已断开";
            break;
        case LFLiveError:
            status = @"连接出错";
            break;
        default:
            break;
    }
    self.statusBtn.text = [NSString stringWithFormat:@"状态: %@\nRTMP: %@", status, self.rtmpUrl];
}

@end
