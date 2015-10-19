//
//  BottomButton.m
//  WeCommunity
//
//  Created by Harry on 9/30/15.
//  Copyright © 2015 Harry. All rights reserved.
//

#import "BottomButton.h"

@implementation BottomButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.firstBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.firstBtn.frame = CGRectMake(0, 0, frame.size.width/2-1, frame.size.height);
        [self.firstBtn configureButtonTitle:@"电话报修" backgroundColor:THEMECOLOR];
        [self addSubview:self.firstBtn];
        
        self.secondBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.secondBtn.frame = CGRectMake(frame.size.width/2, 0, frame.size.width/2-1, frame.size.height);
        [self.secondBtn configureButtonTitle:@"提交报修" backgroundColor:THEMECOLOR];
        [self addSubview:self.secondBtn];
    }
    return self;
}

@end
