//
//  SummerBillTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/2.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerBillTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView *cellImgSelect;
@property(nonatomic,weak)IBOutlet UILabel *cellName;
@property(nonatomic,weak)IBOutlet UILabel *cellPrice;

- (void)configureBillCellConten:(NSDictionary *)dicTemp withSelectOrNot:(BOOL)isSelected;

@end
