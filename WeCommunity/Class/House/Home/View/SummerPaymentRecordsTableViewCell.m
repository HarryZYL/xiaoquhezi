//
//  SummerPaymentRecordsTableViewCell.m
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import "SummerPaymentRecordsTableViewCell.h"

@implementation SummerPaymentRecordsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)confirmCellWithData:(NSDictionary *)dicTemp{
    
}

- (IBAction)deletePaymentRecords:(UIButton *)sender{
    [self.delegate summerPaymentRecordsDeleteCellDataWithData:sender];
}

@end
