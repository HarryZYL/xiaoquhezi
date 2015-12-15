//
//  SummerAddressView.m
//  WeCommunity
//
//  Created by madarax on 15/12/15.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerAddressView.h"

@implementation SummerAddressView

- (instancetype)init{
    if (self = [super init]) {
        __weak typeof(self)weakSelf = self;
        NSArray *nameArrary = @[@"收货人姓名",@"手机号码",@"所在区域",@"详细地址"];
        for (NSInteger index = 0; index < 4; index ++) {
            UILabel *nameLab = [UILabel new];
            nameLab.font = [UIFont systemFontOfSize:14];
            nameLab.tag = index + 1;
            nameLab.text = nameArrary[index];
            [self addSubview:nameLab];
            [nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.mas_left).offset(10);
                make.top.equalTo(weakSelf.mas_top).offset(183/4*index);
                make.width.mas_equalTo(80);
                make.height.mas_equalTo(183/4);
            }];
            if (index != 3) {
                UILabel *lineLab = [UILabel new];
                lineLab.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000];
                [self addSubview:lineLab];
                [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(weakSelf.mas_left).offset(10);
                    make.right.equalTo(weakSelf.mas_right);
                    make.top.equalTo(weakSelf.mas_top).offset(183/4 * (index + 1));
                    make.height.mas_equalTo(.5);
                }];
            }
            switch (index) {
                case 0:
                {
                    _nameText = [UITextField new];
                    _nameText.placeholder = @"您的姓名";
                    _nameText.font = [UIFont systemFontOfSize:15];
                    [self addSubview:_nameText];
                    [self confirmAutoLayoutWithView:_nameText leftControll:nameLab];
                }
                    break;
                case 1:
                {
                    _phoneText = [UITextField new];
                    _phoneText.placeholder = @"联系您的电话";
                    _phoneText.font = [UIFont systemFontOfSize:15];
                    _phoneText.keyboardType = UIKeyboardTypePhonePad;
                    [self addSubview:_phoneText];
                    [self confirmAutoLayoutWithView:_phoneText leftControll:nameLab];
                }
                    break;
                case 2:
                {
                    _btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
                    [_btnAddress setTitle:@"所在区域" forState:UIControlStateNormal];
                    [_btnAddress setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                    [_btnAddress setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                    _btnAddress.titleLabel.font = [UIFont systemFontOfSize:15];
                    [self addSubview:_btnAddress];
                    [self confirmAutoLayoutWithView:_btnAddress leftControll:nameLab];
                }
                    break;
                case 3:
                {
                    _addressInformation = [UITextField new];
                    _addressInformation.placeholder = @"您的门牌号等详细信息";
                    _addressInformation.font = [UIFont systemFontOfSize:15];
                    [self addSubview:_addressInformation];
                    [self confirmAutoLayoutWithView:_addressInformation leftControll:nameLab];
                }
                    break;
                    
                default:
                    break;
            }
        }

    }
                return self;
}

- (void)confirmAutoLayoutWithView:(id)sender leftControll:(UIView *)nameLabel{
    __weak typeof(self)weakSelf = self;
    [sender mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel.mas_right).offset(10);
        make.right.equalTo(weakSelf.mas_right);
        make.height.mas_equalTo(183/4);
        make.top.equalTo(nameLabel.mas_top);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
