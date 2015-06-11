//
//  GameModeViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "GameModeViewController.h"

@interface GameModeViewController ()

@end

@implementation GameModeViewController

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
    // Do any additional setup after loading the view.
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

- (IBAction)saveGameMode:(id)sender {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    UIButton* btn = sender;
    if (btn.tag==0) { // 随机模式
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        NSString* rangeStr = [defaults objectForKey:@"NumRange"];
        int rangeInt = [rangeStr intValue];
        // 产生随机数
        int bombNum = arc4random() % (rangeInt+1);
        // 存储数据
        [defaults setObject:[NSString stringWithFormat:@"%d",bombNum] forKey:@"BombNum"];
        // 立刻同步
        [defaults synchronize];
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"BombNum"]);
    }
}
@end
