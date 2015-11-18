//
//  BottomButton.m
//  WeCommunity
//
//  Created by Harry on 9/30/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "BottomButton.h"

@implementation BottomButton
#define BOOTOM_BUTTON_COLOR [UIColor colorWithRed:0.239 green:0.800 blue:0.706 alpha:1.000]
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.firstBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.firstBtn.frame = CGRectMake(0, 0, frame.size.width/2-1, frame.size.height);
        [self.firstBtn configureButtonTitle:@"电话报修" backgroundColor:BOOTOM_BUTTON_COLOR];
        
        [self addSubview:self.firstBtn];
        
        self.secondBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.secondBtn.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2-1, frame.size.height);
        [self.secondBtn configureButtonTitle:@"提交报修" backgroundColor:BOOTOM_BUTTON_COLOR];
        [self addSubview:self.secondBtn];
    }
    return self;
}

@end
