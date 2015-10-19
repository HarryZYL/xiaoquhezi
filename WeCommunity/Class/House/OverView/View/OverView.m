//
//  OverView.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "OverView.h"

@implementation OverView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        for (int i = 0; i<3; i++) {
            
            CGFloat height = 50;
            
            CallView *callView1 = [[CallView alloc] initWithFrame:CGRectMake(0, height * i, frame.size.width, 40)];
            callView1.titleLabel.text = @"报修电话";
            callView1.tellLabel.text =@"123456";
            [self addSubview:callView1];
        }
        
        
    }
    return self;
}

@end
