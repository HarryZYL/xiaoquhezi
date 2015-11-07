//
//  SummerNoticeDetailTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/4.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerNoticeDetailTableViewCell.h"

@implementation SummerNoticeDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cellTitleImg.layer.cornerRadius = self.cellTitleImg.frame.size.width/2;
    self.cellTitleImg.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
