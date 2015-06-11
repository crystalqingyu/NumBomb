//
//  HanziToNum.h
//  NumBomb
//
//  Created by Julie on 15/4/15.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HanziToNum : NSObject

@property (nonatomic, copy) NSString* hanziStr; // 转换前的汉字数字
@property (nonatomic, assign) int num; // 转换后的数字
@property (nonatomic, strong) NSDictionary* dict; // 对应字典列表

- (void)change;

@end
