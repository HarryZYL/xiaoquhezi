//
//  SummerAlertView.m
//  WeCommunity
//
//  Created by madarax on 15/10/27.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerAlertView.h"

@interface SummerAlertView()
{
    IBOutlet UIView *bgView;
    IBOutlet UILabel *titleName;
    IBOutlet UILabel *detaillText;
    IBOutlet UIButton *btnSure;
    IBOutlet UIButton *btnCansole;
}

@end

@implementation SummerAlertView

- (void)awakeFromNib{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.5];

    [self confirmLayerCornerWithView:bgView];
    [self confirmLayerCornerWithView:btnCansole];
    [self confirmLayerCornerWithView:btnSure];
}

- (void)confirmLayerCornerWithView:(id)layerView{
    UIView *layerViewCorner = layerView;
    layerViewCorner.layer.cornerRadius = 3;
    layerViewCorner.layer.masksToBounds = YES;
}

- (IBAction)alertViewBtnSureOrCansole:(UIButton *)sender{
    [self.delegate summerAlertViewClickIndex:sender.tag];
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

- (void)dealloc{
    self.delegate = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
