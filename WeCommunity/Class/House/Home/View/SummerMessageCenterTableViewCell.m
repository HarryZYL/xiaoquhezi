//
//  SummerMessageCenterTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerMessageCenterTableViewCell.h"

@implementation SummerMessageCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cellPointCenter.layer.cornerRadius = self.cellPointCenter.frame.size.width/2.0;
    self.cellPointCenter.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
