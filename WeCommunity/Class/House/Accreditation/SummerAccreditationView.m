//
//  SummerAccreditationView.m
//  WeCommunity
//
//  Created by madarax on 16/1/19.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "SummerAccreditationView.h"

@implementation SummerAccreditationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *errorImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"new168"]];
        errorImage.contentMode = UIViewContentModeCenter;
        [self addSubview:errorImage];
        __weak typeof(self)weakSelf = self;
        [errorImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(84);
            make.centerX.equalTo(weakSelf.mas_centerX);
            make.centerY.equalTo(weakSelf.mas_centerY).offset(-120);
        }];
        _labNoError = [[UILabel alloc] init];
        _labNoError.font = [UIFont systemFontOfSize:13];
        _labNoError.textColor = [UIColor lightGrayColor];
        _labNoError.textAlignment = NSTextAlignmentCenter;
        _labNoError.text = @"你还没有认证信息，快去添加认证啦~";
        [self addSubview:_labNoError];
        [_labNoError mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(errorImage.mas_bottom).offset(20);
            make.centerX.equalTo(errorImage.mas_centerX);
            make.height.mas_equalTo(20);
            make.width.equalTo(weakSelf.mas_width);
        }];
        _addAccredi = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addAccredi setBackgroundColor:THEMECOLOR];
        _addAccredi.layer.cornerRadius = 5;
        _addAccredi.layer.masksToBounds = YES;
        [_addAccredi setTitle:@"添加认证" forState:UIControlStateNormal];
        [self addSubview:_addAccredi];
        [_addAccredi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(110);
            make.height.mas_equalTo(40);
            make.top.equalTo(weakSelf.labNoError.mas_bottom).offset(20);
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
