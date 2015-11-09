//
//  SummerCommunityBrowserTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerCommunityBrowserTableViewCell.h"

@implementation SummerCommunityBrowserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.borderColor = [UIColor grayColor].CGColor;
    _bgView.layer.borderWidth = 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
