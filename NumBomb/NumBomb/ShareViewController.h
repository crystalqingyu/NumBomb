//
//  ShareViewController.h
//  Macaca
//
//  Created by Julie on 15/3/26.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApiObject.h"

@protocol shareByWeixinDelegate <NSObject>
- (void) changeScene:(NSInteger)scene;
- (void) sendByWeixin;
@end

@protocol shareByWeiboDelegate <NSObject>
- (void) sendByWeibo;
@end

@protocol shareByQQKongjianDelegate <NSObject>
- (void) sendByQQKongjian;
@end

@interface ShareViewController : UIViewController

@property (nonatomic, assign) id<shareByWeixinDelegate,NSObject> weixinDelegate;
@property (nonatomic, assign) id<shareByWeiboDelegate,NSObject> weiboDelegate;
@property (nonatomic, assign) id<shareByQQKongjianDelegate,NSObject> qqKongjianDelegate;
@property (strong, nonatomic) IBOutlet UIView *blankView;
@property (strong, nonatomic) IBOutlet UIButton *weixinBtn;
@property (strong, nonatomic) IBOutlet UIButton *pengyouquanBtn;
@property (strong, nonatomic) IBOutlet UIButton *weiboBtn;
@property (strong, nonatomic) IBOutlet UIButton *qqkongjianBtn;
@property (nonatomic, assign) SystemSoundID* btnSound;
- (IBAction)shareWeixinFriends;
- (IBAction)shareWeixinFriendsCircle;
- (IBAction)shareWeibo;
- (IBAction)shareQQKongjian;

- (IBAction)backToHomePage;

@end
