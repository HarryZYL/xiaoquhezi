//
//  SigninDate.m
//  WeCommunity
//
//  Created by Harry on 7/27/15.
//  Copyright (c) 2015 Harry. All rights reserved.
//

#import "SigninDate.h"

@implementation SigninDate

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        
        self.line = [[GrayLine alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 1)];
        [self addSubview:self.line];
        
        self.dateView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, frame.size.width-40, frame.size.height-20)];
        [self addSubview:self.dateView];
        
        CGFloat itemWidth = 50;
        CGFloat itemHeignt = 90;
        CGFloat margin = (self.dateView.frame.size.width - itemWidth * 4)/3;
        
        for (int i=0 ; i<2; i++) {
            
            for (int j = 0; j<4; j++) {
                UIImageView *dateImg = [[UIImageView alloc] init];
                dateImg.frame = CGRectMake((margin+itemWidth)*j, itemHeignt*i, itemWidth, itemWidth);
                dateImg.image = [UIImage imageNamed:@"signinDate"];
                [self.dateView addSubview:dateImg];
                
                UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, itemWidth, 30)];
                dateLabel.center = dateImg.center;
                dateLabel.textAlignment = NSTextAlignmentCenter;
                dateLabel.text = @"07/14";
                dateLabel.textColor = [UIColor whiteColor];
                [self.dateView addSubview:dateLabel];
                
                UILabel *titleLabel = [[UILabel alloc] init];
                titleLabel.frame = CGRectMake((margin+itemWidth)*j, itemHeignt*i+itemWidth, itemWidth, itemHeignt-itemWidth);
                titleLabel.text = @"已签";
                titleLabel.textAlignment = NSTextAlignmentCenter;
                [self.dateView addSubview:titleLabel];
            }
        }
        self.bottomLine = [[GrayLine alloc] initWithFrame:CGRectMake(0, self.dateView.frame.origin.y+self.dateView.frame.size.height, frame.size.width, 30)];
        self.bottomLine.titleLabel.text = @"积分记录";
        [self addSubview:self.bottomLine];
        
    }
    return self;
}

        
@end
