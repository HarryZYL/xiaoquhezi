//
//  SummerSelectAddressTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import "SummerSelectAddressTableViewCell.h"

@implementation SummerSelectAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)confirmCellContentWithData:(NSDictionary *)dic{
    _cellNameContent.text = [NSString stringWithFormat:@"%@%@",dic[@"name"],dic[@"phone"]];
    _cellAddressLab.text = [NSString stringWithFormat:@"%@%@%@",dic[@"provinceName"],dic[@"cityName"],dic[@"districtName"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
