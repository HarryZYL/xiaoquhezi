//
//  SummerCollectionTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/12/7.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SummerStarView.h"

@interface SummerCollectionTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellImgView;
@property (nonatomic ,weak)IBOutlet SummerStarView *cellStarView;
@property (nonatomic ,weak)IBOutlet UILabel *cellPrice;
@property (nonatomic ,weak)IBOutlet UILabel *cellTitleLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellDistribution;

@property (nonatomic ,weak)IBOutlet NSLayoutConstraint *layoutStarWidth;

- (void)confirmCellContentWithData:(NSDictionary *)dicData;

@end
