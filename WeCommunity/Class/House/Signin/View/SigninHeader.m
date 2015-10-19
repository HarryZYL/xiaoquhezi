//
//  SigninHeader.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SigninHeader.h"

@implementation SigninHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.functionBtn setImage:[UIImage imageNamed:@"advise"] forState:UIControlStateNormal];
        
        self.userLabel.text = @"总共签到12天 连续签到0天";

    }
    return self;
}

@end
