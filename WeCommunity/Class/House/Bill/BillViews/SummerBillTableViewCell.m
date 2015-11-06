//
//  SummerBillTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerBillTableViewCell.h"

@implementation SummerBillTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)configureBillCellConten:(NSDictionary *)dicTemp withSelectOrNot:(BOOL)isSelected{
    if (isSelected) {
        self.cellImgSelect.image = [UIImage imageNamed:@"未勾选－设计"];
    }else{
        self.cellImgSelect.image = [UIImage imageNamed:@"选中－设计"];
    }
    NSString *strName = [NSString stringWithFormat:@"%@年%@月物业费",dicTemp[@"year"],dicTemp[@"month"]];
    self.cellName.text = strName;
    
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%.2f元",[dicTemp[@"fee"] floatValue]]];
    
    [attributeStr addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor colorWithRed:61/255.0 green:204/255.0 blue:180/255.0 alpha:1]} range:NSMakeRange(0, attributeStr.length - 1)];
    self.cellPrice.attributedText =  attributeStr;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
