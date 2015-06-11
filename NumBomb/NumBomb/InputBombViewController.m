//
//  InputBombViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "InputBombViewController.h"

@interface InputBombViewController () <UITextFieldDelegate>

@end

@implementation InputBombViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化数组
    _waitingBombNumsStr = [[NSMutableArray alloc] init];
    // 初始化炸弹范围
    _numRange = [[NSUserDefaults standardUserDefaults] objectForKey:@"NumRange"];
    // 初始化炸弹范围label
    _numRangeLab.text = [NSString stringWithFormat:@"0-%@",_numRange];
    // 初始化_textField
    _waittingBombNumStr.clearsOnBeginEditing = YES;
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)joinBombNums {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    if ([_waittingBombNumStr.text isEqualToString:@""]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"你还没有输入炸弹哦！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        if ([_waittingBombNumStr.text intValue]<0||[_waittingBombNumStr.text intValue]>[_numRange intValue]) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"你输入的炸弹不在范围内，重新输入！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            // 添加数字
            [self.waitingBombNumsStr addObject:self.waittingBombNumStr.text];
            // 修改已有炸弹数量label
            self.bombsCount.text = [NSString stringWithFormat:@"%d",self.waitingBombNumsStr.count];
        }
    }
    _waittingBombNumStr.text = @"";
    [_waittingBombNumStr resignFirstResponder];
}

- (IBAction)submit {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    if (_waitingBombNumsStr.count==0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"还没有可选数字作为炸弹！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        [self performSegueWithIdentifier:@"InputBombToGameStart" sender:nil];
    }
}

// 点击屏幕空白收键盘
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.waittingBombNumStr resignFirstResponder];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"prepare");
    // 从候选中生存数字炸弹存入文件中
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    int rangeInt = self.waitingBombNumsStr.count;
    // 产生随机数
    int bombNumIndex = arc4random() % (rangeInt);
    NSString* bombNum = self.waitingBombNumsStr[bombNumIndex];
    // 存储数据
    [defaults setObject:bombNum forKey:@"BombNum"];
    // 立刻同步
    [defaults synchronize];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"BombNum"]);
}
- (void)dealloc {
    [_numRangeLab release];
    [_waittingBombNumStr release];
    [_waitingBombNumsStr release];
    [_bombsCount release];
    [super dealloc];
}
@end
