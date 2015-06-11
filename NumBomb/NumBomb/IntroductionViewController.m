//
//  IntroductionViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/17.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "IntroductionViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 添加手势
    UITapGestureRecognizer*tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBackToHomePageView:)];
    [self.view addGestureRecognizer:tapGesture];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backHomePage {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)actionBackToHomePageView:(id)sender {
    [self backHomePage];
}

- (void)dealloc {
    [_ruleImageView release];
    [super dealloc];
}
@end
