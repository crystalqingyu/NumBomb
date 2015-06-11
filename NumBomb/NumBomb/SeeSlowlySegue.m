//
//  SeeSlowlySegue.m
//  NumBomb
//
//  Created by Julie on 15/4/10.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "SeeSlowlySegue.h"

@implementation SeeSlowlySegue

- (void)perform {
    UIViewController * svc = self.sourceViewController;
    UIViewController * dvc = self.destinationViewController;
    [svc.view addSubview:dvc.view];
    [dvc.view setFrame:svc.view.frame];
//    [dvc.view setTransform:CGAffineTransformMakeScale(0.1, 0.1)];
    [dvc.view setAlpha:0.0];
    [UIView animateWithDuration:1.0
                     animations:^{
//                         [dvc.view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                         [dvc.view setAlpha:1.0];
                     }
                     completion:^(BOOL finished) {
                         [svc.navigationController pushViewController:dvc animated:NO];
                     }];
}

@end
