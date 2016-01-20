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
            make.centerY.equalTo(weakSelf.mas_centerY).offset(-120);
        }];
        _labNoError = [[UILabel alloc] init];
        _labNoError.textColor = [UIColor lightGrayColor];
        _labNoError.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_labNoError];
        [_labNoError mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(errorImage.mas_bottom).offset(20);
            make.centerX.equalTo(errorImage.mas_centerX);
            make.height.mas_equalTo(20);
            make.width.equalTo(weakSelf.mas_width);
        }];
        _addNoErrorMore = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addNoErrorMore setBackgroundColor:THEMECOLOR];
        _addNoErrorMore.layer.cornerRadius = 5;
        _addNoErrorMore.layer.masksToBounds = YES;
        [self addSubview:_addNoErrorMore];
        [_addNoErrorMore mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.labNoError.mas_bottom).offset(20);
            make.width.mas_equalTo(60);
            make.height.mas_equalTo(30);
            make.centerX.equalTo(weakSelf.labNoError.mas_centerX);
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
