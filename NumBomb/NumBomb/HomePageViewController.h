//
//  HomePageViewController.h
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface HomePageViewController : UIViewController
- (IBAction)introductGame;
- (IBAction)share;
- (IBAction)focus; // 关注开发者其他应用，好评
- (IBAction)downOtherApp;
- (IBAction)wellComment;
- (IBAction)backHomePage;

@property (nonatomic, assign) SystemSoundID* btnSound;
@property (retain, nonatomic) IBOutlet UIView *auvFocusView;

@end
