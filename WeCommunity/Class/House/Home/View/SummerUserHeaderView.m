//
//  SummerUserHeaderView.m
//  WeCommunity
//
//  Created by madarax on 15/10/29.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerUserHeaderView.h"

@implementation SummerUserHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UIImageView *leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, frame.size.height)];
        leftImage.contentMode = UIViewContentModeCenter;
        leftImage.image = [UIImage imageNamed:@"点点点个人主页"];
        [self addSubview:leftImage];
        
        _btnUserImageView = [UIImageView new];
        [_btnUserImageView setFrame:CGRectMake(10, 6, 32, 32)];
        _btnUserImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_btnUserImageView];
        _btnUserImageView.layer.cornerRadius = 16;
        _btnUserImageView.layer.masksToBounds = YES;
        _touchViews = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_touchViews];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
