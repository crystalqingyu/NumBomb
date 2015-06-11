//
//  ShareViewController.m
//  Macaca
//
//  Created by Julie on 15/3/26.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.weixinDelegate = [UIApplication sharedApplication].delegate;
    self.weiboDelegate = [UIApplication sharedApplication].delegate;
    self.qqKongjianDelegate = [UIApplication sharedApplication].delegate;
    // 添加手势
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBackToHomePageView:)];
    [self.blankView addGestureRecognizer:tapGesture];
    // 按钮变圆
    [self setBtnRound];
    // 创建按钮播放器
    // _btnSound = kSystemSoundID_Vibrate;//震动
    NSString *path = @"/System/Library/Audio/UISounds/Tock.caf";
    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_btnSound);
        
        if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
            _btnSound = nil;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)actionBackToHomePageView:(id)sender {
    [self backToHomePage];
}

- (void)setBtnRound {
    // 朋友圈
    self.pengyouquanBtn.layer.cornerRadius = self.pengyouquanBtn.frame.size.width/2;
    self.pengyouquanBtn.layer.masksToBounds = YES;
    // 微信
    self.weixinBtn.layer.cornerRadius = self.weixinBtn.frame.size.width/2;
    self.weixinBtn.layer.masksToBounds = YES;
    // 微博
    self.weiboBtn.layer.cornerRadius = self.weiboBtn.frame.size.width/2;
    self.weiboBtn.layer.masksToBounds = YES;
    // 朋友圈
    self.qqkongjianBtn.layer.cornerRadius = self.qqkongjianBtn.frame.size.width/2;
    self.qqkongjianBtn.layer.masksToBounds = YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)shareWeixinFriends {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [_weixinDelegate changeScene:WXSceneSession];
    [_weixinDelegate sendByWeixin];
}

- (IBAction)shareWeixinFriendsCircle {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [_weixinDelegate changeScene:WXSceneTimeline];
    [_weixinDelegate sendByWeixin];
}

- (IBAction)shareWeibo {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [_weiboDelegate sendByWeibo];
}

- (IBAction)shareQQKongjian {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [_qqKongjianDelegate sendByQQKongjian];
}
// 返回上一级控制器动画
- (IBAction)backToHomePage {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [UIView animateWithDuration:0.75f animations:^{
        [self.view setFrame:CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width, self.view.frame.size.height)];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}
-(void)dealloc {
    [_blankView release];
    [_weixinBtn release];
    [_pengyouquanBtn release];
    [_weiboBtn release];
    [_qqkongjianBtn release];
    [super dealloc];
}
@end
