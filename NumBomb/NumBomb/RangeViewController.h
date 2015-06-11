//
//  RangeViewController.h
//  NumBomb
//
//  Created by Julie on 15/4/8.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RangeViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *numRange;

- (IBAction)backHomePage;
- (IBAction)submit;

@property (nonatomic, assign) SystemSoundID* btnSound;
@end
