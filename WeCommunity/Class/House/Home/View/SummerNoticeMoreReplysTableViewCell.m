//
//  SummerNoticeMoreReplysTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeMoreReplysTableViewCell.h"

@implementation SummerNoticeMoreReplysTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _cellUserImage.layer.cornerRadius = _cellUserImage.frame.size.width/2;
    _cellUserImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
