//
//  GoInFromRightSegue.m
//  NumBomb
//
//  Created by Julie on 15/4/17.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "GoInFromRightSegue.h"

@implementation GoInFromRightSegue

- (void)perform {
    UIViewController * svc = self.sourceViewController;
    UIViewController * dvc = self.destinationViewController;
    if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
        
        dvc.modalPresentationStyle=UIModalPresentationOverFullScreen;
        
    }else{
        
        dvc.modalPresentationStyle=UIModalPresentationCurrentContext;
        
    }
    [svc.view addSubview:dvc.view];
    [dvc.view setFrame:CGRectMake(svc.view.frame.size.width, 0, svc.view.frame.size.width, svc.view.frame.size.height)];
    [UIView animateWithDuration:0.75
                     animations:^{
                         //                         [dvc.view setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                         [dvc.view setFrame:svc.view.frame];
                     }
                     completion:^(BOOL finished) {
                         [svc.navigationController presentViewController:dvc animated:NO completion:nil];
                     }];

}

@end
