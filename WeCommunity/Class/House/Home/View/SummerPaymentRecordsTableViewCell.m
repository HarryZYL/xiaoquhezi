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

- (void)confirmCellWithData:(SummerPaymentListModel *)dicTemp{
    NSString *strTemp = [NSString stringWithFormat:@"%@物业费，共%@元" ,dicTemp.dates,dicTemp.fee];
    self.cellLabPaymentProject.text = strTemp;
    self.cellLabPropertyManagement.text = dicTemp.propertyName;
    self.cellLabRoomAddress.text = [NSString stringWithFormat:@"%@%@", dicTemp.communityName,dicTemp.parentNames];
    self.cellLabPaymentTime.text = [NSString stringWithFormat:@"%@ 缴费成功",dicTemp.payTime];
}

- (IBAction)deletePaymentRecords:(UIButton *)sender{
    [self.delegate summerPaymentRecordsDeleteCellDataWithData:sender];
}

@end
