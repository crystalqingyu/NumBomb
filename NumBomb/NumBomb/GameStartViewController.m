//
//  GameStartViewController.m
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "GameStartViewController.h"

@interface GameStartViewController () <AVAudioRecorderDelegate,MVoiceRecognitionClientDelegate,UIAlertViewDelegate> {
    
}

@end

@implementation GameStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化_currentNum
    _currentNum = @"-1";
    // 加载炸弹范围label
    NSString* numRangeStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"NumRange"];
    self.rangeLab.text = [NSString stringWithFormat:@"0 - %@",numRangeStr];
    // 创建按钮播放器
    // _btnSound = kSystemSoundID_Vibrate;//震动
    NSString *path = @"/System/Library/Audio/UISounds/Tock.caf";
    if (path) {
        OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_btnSound);
        
        if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
            _btnSound = nil;
        }
    }
    // 初始化爆炸播放
    NSString *string = [[NSBundle mainBundle] pathForResource:@"baozha" ofType:@"mp3"];
    //把音频文件转换成url格式
    NSURL *url = [NSURL fileURLWithPath:string];
    //初始化音频类 并且添加播放文件
    _bombPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //设置代理
    _bombPlayer.delegate = self;
    //设置音乐播放次数  -1为一直循环
    _bombPlayer.numberOfLoops = 2;
    //预播放
    [_bombPlayer prepareToPlay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)backHomePage {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)finishRecord {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [[BDVoiceRecognitionClient sharedInstance] speakFinish];
}

- (void)VoiceRecognitionClientWorkStatus:(int)aStatus obj:(id)aObj {
    switch (aStatus)
    {
        case EVoiceRecognitionClientWorkStatusError: // 错误
        {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"录音出现错误，再说一遍吧 ！"] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [self.inputTipImageView setImage:[UIImage imageNamed:@"bombt_0001s_0001_按住喇叭-说数字.png"]];
            break;
        }
        case EVoiceRecognitionClientWorkStatusFinish: // 识别正常完成并获得结果
        {
            // 该状态值表示语音识别服务器返回了最终结果，结果以数组的形式保存在 aObj 对象中
            // 接受到该消息时应当清空显示区域的文字以免重复
            if ([_sharedInstance getRecognitionProperty] != EVoiceRecognitionPropertyInput)
            {
                NSMutableArray *resultData = (NSMutableArray *)aObj;
                NSMutableString *tmpString = [[NSMutableString alloc] initWithString:@""];
                // 获取识别候选词列表
                for (int i=0; i<[resultData count]; i++)
                {
                    [tmpString appendFormat:@"%@\r\n",[resultData objectAtIndex:i]];
                }
                NSLog(@"result: %@", tmpString);
            }
            else
            {
                NSMutableString *sentenceString = [[NSMutableString alloc] initWithString:@""];
                for (NSArray *result in aObj)// 此时 aObj 是 array，result 也是 array
                {
                    // 取每条候选结果的第一条，进行组合
                    // result 的元素是 dictionary，对应一个候选词和对应的可信度
                    NSDictionary *dic = [result objectAtIndex:0];
                    NSString *candidateWord = [[dic allKeys] objectAtIndex:0];
                    [sentenceString appendString:candidateWord];
                }
                NSLog(@"result: %@", sentenceString);
                HanziToNum* change = [[HanziToNum alloc] init];
                change.hanziStr = sentenceString;
                [change change];
                _currentNum = [NSString stringWithFormat:@"%d",change.num];
                NSLog(@"%@",_currentNum);
                UIAlertView* alert = [[UIAlertView alloc] initWithTitle:_currentNum message:nil delegate:self cancelButtonTitle:@"不对，重新说数字" otherButtonTitles:@"说的就是它！", nil];
                [alert show];
            }
            break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([alertView.title isEqualToString:_currentNum]) { // 录音成功的alertView
        if (buttonIndex==0) { // 不对，重新说数字
            [self.inputTipImageView setImage:[UIImage imageNamed:@"bombt_0001s_0001_按住喇叭-说数字.png"]];
        } else { // 没错，就是它！
            if ([_currentNum isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"BombNum"]]) { // 中了炸弹
                // 播放声音
                // 播放动画
                [UIView animateWithDuration:1.5 animations:^(void){
                    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
                    _zhadanImageView.frame = CGRectMake(_zhadanImageView.frame.origin.x-20, _zhadanImageView.frame.origin.y-20, _zhadanImageView.frame.size.width+40, _zhadanImageView.frame.size.height+40);
                }completion:^(BOOL finished){
                    _bomb = [[UIImageView alloc] init];
                    _bomb.backgroundColor = [UIColor colorWithRed:255.0/255 green:253.0/255 blue:198.0/255 alpha:1];
                    _bomb.frame = self.view.frame;
                    [self.view addSubview:_bomb];
                    NSMutableArray  *arrayM=[NSMutableArray array];
                    for (int i=0; i<6; i++) {
                        [arrayM addObject:[UIImage imageNamed:[NSString stringWithFormat:@"bombexplode-%d.png",i]]];
                    }
                    //设置动画数组
                    [_bomb setAnimationImages:arrayM];
                    //设置动画播放次数
                    [_bomb setAnimationRepeatCount:1];
                    //设置动画播放时间
                    [_bomb setAnimationDuration:42*0.1];
                    //开始动画
                    [_bomb startAnimating];
                    [_bombPlayer play];
                    // 5. 动画播放完成后
                    [self performSelector:@selector(didFinish) withObject:nil afterDelay:_bomb.animationDuration+1.5];
                }];
                
            } else { // 没中
                [self.inputTipImageView setImage:[UIImage imageNamed:@"bombt_0001s_0001_按住喇叭-说数字.png"]];
                NSRange range = [_rangeLab.text rangeOfString:@"-"];
                if ([_currentNum intValue]<[[_rangeLab.text substringToIndex:range.location-1] intValue] || [_currentNum intValue]>[[_rangeLab.text substringFromIndex:range.location+2] intValue]) { // 不在范围
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"你说的炸弹不在范围内，重新说数字！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                } else { // 在范围
                    // 修改炸弹范围label
                    if ([_currentNum intValue]<[[[NSUserDefaults standardUserDefaults] objectForKey:@"BombNum"] intValue]) {
                        _rangeLab.text = [NSString stringWithFormat:@"%d - %@",[_currentNum intValue]+1,[_rangeLab.text substringFromIndex:range.location+2]];
                    } else {
                        _rangeLab.text = [NSString stringWithFormat:@"%@ - %d",[_rangeLab.text substringToIndex:range.location-1],[_currentNum intValue]-1];
                    }
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"炸弹范围以改变为 %@ ！",_rangeLab.text] message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }
    }
}
- (void)didFinish {
    _bomb.image = [UIImage imageNamed:@"monkey-black.png"];
    UIButton* restartBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/3, self.view.frame.size.width/3, self.view.frame.size.width/4, self.view.frame.size.width/6)];
    restartBtn.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.875);
    [restartBtn setBackgroundImage:[UIImage imageNamed:@"bombt_0000s_0000_返回.png"] forState:UIControlStateNormal];
    [restartBtn addTarget:self action:@selector(restart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:restartBtn]; // 注意不能是_bomb的add，否则按钮不好使
}
- (void)restart {
    // 播放声音
    AudioServicesPlaySystemSound(_btnSound);
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)dealloc {
    [_inputTipImageView release];
    [_rangeLab release];
    [_recordBtn release];
    [BDVoiceRecognitionClient releaseInstance];
    [_bomb release];
    [_zhadanImageView release];
    [super dealloc];
}
- (IBAction)recordNum {
    // 建立
    _sharedInstance =[BDVoiceRecognitionClient sharedInstance];
    NSLog(@"%@",_sharedInstance);
    [_sharedInstance setPropertyList: @[[NSNumber numberWithInt: EVoiceRecognitionPropertyInput]]];
    [_sharedInstance setLanguage:EVoiceRecognitionLanguageChinese];
    // 开始识别
    [_sharedInstance setApiKey:@"rR6FOj4cs1cfrxIEy3SRi5je" withSecretKey:@"cOLdKWGtT9l1YFTHOObTdgB6wnhjubhe"];
    if ([_sharedInstance isCanRecorder]) {
        int startStatus = [_sharedInstance startVoiceRecognition:self];
        // 错误提示框
        UIAlertView* alert = [[UIAlertView alloc] init];
        switch (startStatus) {
            case EVoiceRecognitionStartWorking: // 录音开始
                [self.inputTipImageView setImage:[UIImage imageNamed:@"bombt_0001s_0000_松开-结束.png"]];
                [_sharedInstance setPlayTone:1 isPlay:YES];
                break;
            case EVoiceRecognitionStartWorkNOMicrophonePermission: // 没有麦克风权限
                [alert initWithTitle:@"没有麦克风权限，快去设置哦！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            case EVoiceRecognitionStartWorkNetUnusable: // 网络原因
                [alert initWithTitle:@"当前网络不给力哦！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            case EVoiceRecognitionStartWorkRecorderUnusable: // 麦克风不好使
                [alert initWithTitle:@"麦克风出问题了！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                break;
            default:
                break;
        }
    }
}
@end
