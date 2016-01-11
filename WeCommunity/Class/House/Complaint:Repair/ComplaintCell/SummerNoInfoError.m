//
//  SummerNoInfoError.m
//  WeCommunity
//
//  Created by madarax on 16/1/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerNoInfoError.h"

@implementation SummerNoInfoError

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *errorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"暂无数据168"]];
        errorImage.contentMode = UIViewContentModeCenter;
        [self addSubview:errorImage];
        __weak typeof(self)weakSelf = self;
        [errorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(84);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY).offset(-40);
        }];
        _labNoError = [[UILabel alloc] init];
        _labNoError.textColor = [UIColor colorWithWhite:0.259 alpha:1.000];
        _labNoError.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labNoError];
        [_labNoError mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(errorImage.mas_bottom).offset(20);
            make.centerX.equalTo(errorImage.mas_centerX);
            make.height.mas_equalTo(20);
            make.width.equalTo(weakSelf.mas_width);
        }];
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
