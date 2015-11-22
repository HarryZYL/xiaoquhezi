//
//  SummerRepairListsRepairCellTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerRepairListsRepairCellTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellTitleImg;
@property (nonatomic ,weak)IBOutlet UILabel *cellTitleName;
@property (nonatomic ,weak)IBOutlet UILabel *cellTimeLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellContent;

@property (nonatomic ,weak)IBOutlet NSLayoutConstraint *cellContentLayout;

- (void)confirmsCellDataWithData:(NSDictionary *)dicTemp;

@end
