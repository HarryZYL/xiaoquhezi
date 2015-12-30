//
//  SummerScoreTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerScoreTableViewCell.h"

@implementation SummerScoreTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.cellExchange.layer.cornerRadius = 5;
    self.cellExchange.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
