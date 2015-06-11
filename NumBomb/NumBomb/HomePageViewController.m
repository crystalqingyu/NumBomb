//
//  HomePageViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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

// 存储数字范围
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    UIButton* rangeBtn = sender;
    if (rangeBtn.tag!=1000) {
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        // 存储数据
        [defaults setObject:[NSString stringWithFormat:@"%d",rangeBtn.tag+49] forKey:@"NumRange"];
        // 立刻同步
        [defaults synchronize];
    }
    // NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"NumRange"]);
}
// 去介绍游戏页面
- (IBAction)introductGame {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self performSegueWithIdentifier:@"goToIntroduction" sender:nil];
}
// 去分享页面
- (IBAction)share {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self performSegueWithIdentifier:@"goToShare" sender:nil];
}

- (IBAction)focus {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    NSArray* greenViews = [[NSBundle mainBundle] loadNibNamed:@"AUVFocus" owner:self options:nil];
    UIView* view = greenViews[0];
    view.frame = CGRectMake(self.view.frame.size.width*0.5, self.view.frame.size.width*0.5, 0, 0);
    view.alpha = 0;
    // 缓慢添加View
    [UIView animateWithDuration:0.7 animations:^(void){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        view.frame = CGRectMake(self.view.frame.size.width/6, 0, self.view.frame.size.width/3*2, self.view.frame.size.width);
        view.alpha = 1;
        [self.view addSubview:view];
    }completion:nil];

}
- (IBAction)downOtherApp {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    NSString* appid = @"966621372";
    NSString* str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appid];
    NSURL* url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)wellComment {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    NSString* appid = @"982954370";
    NSString* str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",appid];
    NSURL* url = [NSURL URLWithString:str];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)backHomePage {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [UIView animateWithDuration:0.7 animations:^(void){
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        self.auvFocusView.frame = CGRectMake(self.view.frame.size.width*0.5, self.view.frame.size.width*0.5, 0, 0);
        self.auvFocusView.alpha = 0;
    }completion:^(BOOL finished) {
        [self.auvFocusView removeFromSuperview];
    }];
}
- (void)dealloc {
    [_auvFocusView release];
    [super dealloc];
}
@end
