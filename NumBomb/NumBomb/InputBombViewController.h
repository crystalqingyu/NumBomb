//
//  InputBombViewController.h
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InputBombViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *waittingBombNumStr;
@property (nonatomic, strong) NSMutableArray* waitingBombNumsStr;
@property (strong, nonatomic) IBOutlet UILabel *bombsCount;
@property (retain, nonatomic) IBOutlet UILabel *numRangeLab;
@property (copy, nonatomic) NSString* numRange;
@property (nonatomic, assign) SystemSoundID* btnSound;
- (IBAction)backHomePage;
- (IBAction)joinBombNums;
- (IBAction)submit;
@end
