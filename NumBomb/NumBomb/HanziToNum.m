//
//  HanziToNum.m
//  NumBomb
//
//  Created by Julie on 15/4/15.
//  Copyright (c) 2015年 _VAJASPINE_. All rights reserved.
//

#import "HanziToNum.h"

@implementation HanziToNum

- (instancetype)init {
    if ([super init]) {
        _dict= [[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"零",@"1",@"一" ,@"2",@"二" ,@"3",@"三" ,@"4",@"四" ,@"5",@"五" ,@"6",@"六" ,@"7",@"七" ,@"8",@"八",@"8",@"吧" ,@"9",@"九" ,nil];
    }
    return self;
}

- (void)change {
    NSMutableString* tmpStr = [[NSMutableString alloc] init];
    NSLog(@"%@",self.hanziStr);
    //转数字放入数组中
    for(int i =0;i<_hanziStr.length-1;i++){ // 因为最后一个是句号，所以是length-1
        NSRange range;
        range.length = 1;
        range.location = i;
        if ([_dict objectForKey:[_hanziStr substringWithRange:range]]) {
            [tmpStr appendString:[_dict objectForKey:[_hanziStr substringWithRange:range]]];
        }
        if (i==_hanziStr.length-2) {
            if ([[_hanziStr substringWithRange:range] isEqualToString:@"十"]) {
                [tmpStr appendString:@"0"];
            } else if ([[_hanziStr substringWithRange:range] isEqualToString:@"百"]) {
                [tmpStr appendString:@"00"];
            }
        }
    }
    // 补充规则:12 560
    if ([_hanziStr containsString:@"十"] && tmpStr.length<2) {
        [tmpStr insertString:@"1" atIndex:0];
    } else if ([_hanziStr containsString:@"百"] && tmpStr.length<3) {
        [tmpStr appendString:@"0"];
    }
    _num = [tmpStr intValue];
}

@end
