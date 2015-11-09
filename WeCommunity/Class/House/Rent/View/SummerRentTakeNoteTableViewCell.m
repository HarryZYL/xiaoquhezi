//
//  SummerRentTakeNoteTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/9.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerRentTakeNoteTableViewCell.h"

@implementation SummerRentTakeNoteTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
