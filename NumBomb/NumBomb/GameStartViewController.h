//
//  GameStartViewController.h
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreAudio/CoreAudioTypes.h>
#import "BDVRRawDataRecognizer.h"
#import "BDVRFileRecognizer.h"
#import "HanziToNum.h"


@interface GameStartViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *rangeLab;
@property (retain, nonatomic) IBOutlet UIImageView *inputTipImageView;
@property (strong, nonatomic) IBOutlet UIButton *recordBtn;
@property (retain, nonatomic) IBOutlet UIImageView *zhadanImageView;
@property (nonatomic, strong) BDVoiceRecognitionClient* sharedInstance;
@property (nonatomic, copy) NSString* currentNum;
@property (nonatomic, strong) UIImageView* bomb; // 爆炸后的图片View
@property (nonatomic, assign) SystemSoundID* btnSound;
@property (nonatomic, assign) AVAudioPlayer* bombPlayer;
- (IBAction)backHomePage;
- (IBAction)finishRecord;
- (IBAction)recordNum;

@end
