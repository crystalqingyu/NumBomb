//
//  IntroductionViewController.h
//  NumBomb
//
//  Created by Julie on 15/4/17.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController
- (IBAction)backHomePage;
@property (retain, nonatomic) IBOutlet UIImageView *ruleImageView;
@property (nonatomic, assign) SystemSoundID* btnSound;

@end
