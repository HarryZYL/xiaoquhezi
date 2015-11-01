//
//  SummerPaymentRecordsTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/10/26.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerPaymentListModel.h"

@protocol SummerPaymentRecordsTableViewCellDelegate <NSObject>

- (void)summerPaymentRecordsDeleteCellDataWithData:(UIButton *)sender;

@end

@interface SummerPaymentRecordsTableViewCell : UITableViewCell

@property(nonatomic, weak) id delegate;

@property(nonatomic, weak) IBOutlet UILabel *cellLabPaymentProject;
@property(nonatomic, weak) IBOutlet UILabel *cellLabPropertyManagement;
@property(nonatomic, weak) IBOutlet UILabel *cellLabRoomAddress;
@property(nonatomic, weak) IBOutlet UILabel *cellLabPaymentTime;

- (void)confirmCellWithData:(SummerPaymentListModel *)dicTemp;

@end
