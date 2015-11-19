//
//  SummerRepairListTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/11.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextDeal.h"

@protocol SummerRepairListTableViewCellDelegate <NSObject>

- (void)summerRepairListCellWithData:(UIImageView *)sender;

@end

@interface SummerRepairListTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellImageViewTitle;
@property (nonatomic ,weak)IBOutlet UILabel *cellTitleLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTime;
@property (nonatomic ,weak)IBOutlet UIButton *cellBtnCount;
@property (nonatomic ,weak)IBOutlet UIImageView *cellStyle;

@property (nonatomic ,weak)IBOutlet NSLayoutConstraint *cellLineSingleLayout;

@property (nonatomic ,weak) id delegate;

- (void)confirmRepairListCellWithData:(TextDeal *)textModel;

@end
