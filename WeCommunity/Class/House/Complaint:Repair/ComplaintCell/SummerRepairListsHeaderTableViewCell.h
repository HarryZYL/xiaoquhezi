//
//  SummerRepairListsHeaderTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/10.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextDeal.h"

@interface SummerRepairListsHeaderTableViewCell : UITableViewCell

@property(nonatomic ,weak)IBOutlet UIImageView *cellTitleImageView;
@property(nonatomic ,weak)IBOutlet UILabel *cellTitleName;
@property(nonatomic ,weak)IBOutlet UILabel *cellContentLab;
@property(nonatomic ,weak)IBOutlet UIView *cellImagesView;
@property(nonatomic ,weak)IBOutlet UIView *cellRepairManView;
@property(nonatomic ,weak)IBOutlet UILabel *cellRepairPeople;
@property(nonatomic ,weak)IBOutlet UILabel *cellPhoneNumber;
@property(nonatomic ,weak)IBOutlet UIView *cellRepairTakeNote;
@property(nonatomic ,weak)IBOutlet UILabel *cellTakeNoteLab;

@property(nonatomic ,weak)IBOutlet UILabel *cellLineLab;

- (void)confirmTableViewHeaderViewWithData:(TextDeal *)dicTemp;

@end
