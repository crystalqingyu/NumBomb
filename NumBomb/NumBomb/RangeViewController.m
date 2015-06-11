//
//  RangeViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "RangeViewController.h"

@interface RangeViewController () <UITextFieldDelegate>

@end

@implementation RangeViewController

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

// 存储数字范围
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    // 存储数据
    [defaults setObject:self.numRange.text forKey:@"NumRange"];
    // 立刻同步
    [defaults synchronize];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"NumRange"]);
}
// 点击屏幕空白收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.numRange resignFirstResponder];
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}
// 返回主页
- (IBAction)backHomePage {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)submit {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    if ([_numRange.text isEqualToString:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"你还没有输入自定义炸弹范围哦！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"RangeToGameMode" sender:nil];
    }
}
- (void)dealloc {
    [_numRange release];
    [super dealloc];
}
@end
