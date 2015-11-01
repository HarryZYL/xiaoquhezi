//
//  SummerMemberAlertView.m
//  WeCommunity
//
//  Created by madarax on 15/11/1.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerMemberAlertView.h"

@implementation SummerMemberAlertView

- (void)awakeFromNib{
    self.bgView.layer.cornerRadius  = 5;
    self.bgView.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];
    self.btnInfomation.layer.cornerRadius  = 3;
    [self setBgViewBorder:self.btnInfomation selectOrDiselect:NO];
    self.btnInfomation.layer.masksToBounds = YES;
    
    self.btnRemove.layer.cornerRadius  = 3;
    [self setBgViewBorder:self.btnRemove selectOrDiselect:NO];
    self.btnRemove.layer.masksToBounds = YES;
    
    self.bgView.layer.cornerRadius  = 5;
    self.bgView.layer.masksToBounds = YES;
}

- (void)setBgViewBorder:(UIButton *)sender selectOrDiselect:(BOOL)isSelect{
    if (isSelect) {
        [sender setBackgroundColor:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:184/255.0 alpha:1]];
        [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        sender.layer.borderWidth = 0;
        sender.layer.borderColor = [UIColor colorWithRed:61/255.0 green:204/255.0 blue:184/255.0 alpha:1].CGColor;
    }else{
        [sender setBackgroundColor:[UIColor whiteColor]];
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        sender.layer.borderWidth = 1;
        sender.layer.borderColor = [UIColor colorWithRed:61/255.0 green:204/255.0 blue:184/255.0 alpha:1].CGColor;
    }
}

- (IBAction)summerMemberAlertDidSelect:(UIButton *)sender{
    switch (sender.tag) {
        case 1:
        {
            _currentIndex = sender.tag;
            [self setBgViewBorder:sender selectOrDiselect:YES];
            [self setBgViewBorder:self.btnRemove selectOrDiselect:NO];
        }
            break;
        case 2:
        {
            _currentIndex = sender.tag;
            [self setBgViewBorder:sender selectOrDiselect:YES];
            [self setBgViewBorder:self.btnInfomation selectOrDiselect:NO];
        }
            break;
        case 3:
        {//取消
            [self.delegate didSelectIndexWithInformation:_currentIndex];
            [self removeFromSuperview];
        }
            break;
        case 4:
        {
            [self.delegate didSelectIndexWithInformation:_currentIndex];
            [self removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
