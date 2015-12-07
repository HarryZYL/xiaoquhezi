//
//  SummerCollectionTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/12/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerCollectionTableViewCell.h"

@implementation SummerCollectionTableViewCell

- (void)awakeFromNib {
    // Initialization code
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, self.frame.size.height - 6, SCREENSIZE.width, .5);
    lineLayer.backgroundColor = [UIColor colorWithWhite:0.851 alpha:1.000].CGColor;
    [self.contentView.layer addSublayer:lineLayer];
}

- (void)confirmCellContentWithData:(NSDictionary *)dicData{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
