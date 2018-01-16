//
//  QHScreenCAPViewController.m
//  QHScreenCAPDemo
//
//  Created by chen on 2017/4/23.
//  Copyright © 2017年 chen. All rights reserved.
//

#import "QHScreenCAPViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface QHScreenCAPViewController ()

@property (weak, nonatomic) IBOutlet UIButton *startScreenCAPButton;
@property (weak, nonatomic) IBOutlet UIButton *ibScreenShotsBtn;
@property (weak, nonatomic) IBOutlet UIButton *ibBackBtn;


@property (weak, nonatomic) IBOutlet UIView *screenCAPResultV;
@property (weak, nonatomic) IBOutlet UIView *playerV;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

@end

@implementation QHScreenCAPViewController

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    self.player = nil;
    self.playerLayer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.startScreenCAPButton.layer setBorderWidth:0];
    [self.startScreenCAPButton.layer setMasksToBounds:YES];
    [self.startScreenCAPButton.layer setCornerRadius:self.startScreenCAPButton.bounds.size.width/2];
    
    [self.ibAlertMessageLabel.layer setBorderWidth:0];
    [self.ibAlertMessageLabel.layer setMasksToBounds:YES];
    [self.ibAlertMessageLabel.layer setCornerRadius:15];
}

#pragma mark - Action

//重新录屏
- (IBAction)restartScreenCAPAction:(id)sender {
    [self.delegate restartScreenCAP:self];
    self.startScreenCAPButton.selected = YES;
    [self.startScreenCAPButton setBackgroundColor:[UIColor greenColor]];
}

- (IBAction)ibBackAction:(id)sender {
    [self.delegate toBackCAP:self];
}


//开始录屏
- (IBAction)startScreenCAPAction:(id)sender {
    BOOL bRecording = [self.delegate startScreenCAP:self];
    self.startScreenCAPButton.selected = bRecording;
    if (bRecording == YES) {
//        [_ibScreenShotsBtn setHidden:YES];
        [self.startScreenCAPButton setBackgroundColor:[UIColor redColor]];
    }
    else {
//        [_ibScreenShotsBtn setHidden:NO];
        [self.startScreenCAPButton setBackgroundColor:[UIColor clearColor]];
    }
}
//关闭录屏
- (IBAction)closeScreenCAPAction:(id)sender {
    [self.startScreenCAPButton setBackgroundColor:[UIColor redColor]];
    [self.delegate closeScreenCAP:self];
}

//截屏
- (IBAction)getScreenshotsCAPAction:(id)sender {
    [self.delegate getScreenshotsCAP:self];
}

//关闭录屏视频预览播放器
- (IBAction)closeScreenCAPResultAction:(id)sender {
    [self.player pause];
    self.screenCAPResultV.hidden = YES;
}

//完成录屏，并预览播放视频
- (void)playResultAction:(NSURL *)playUrl {
    [self closeScreenCAPAction:nil];
    return;
    
    
    //录制完播放预览
    self.screenCAPResultV.hidden = NO;
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:playUrl];
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    [self.playerV.layer addSublayer:self.playerLayer];
    self.playerLayer.frame = self.playerV.bounds;
    [self.player play];
}


//不支持旋转
-(BOOL)shouldAutorotate
{
    return NO;
}
@end
