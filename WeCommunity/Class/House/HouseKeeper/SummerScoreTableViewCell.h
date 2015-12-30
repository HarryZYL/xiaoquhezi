//
//  SummerScoreTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/12/10.
//  Copyright © 2015年 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerScoreTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellImgView;
@property (nonatomic ,weak)IBOutlet UILabel *cellTitleLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellScoreLab;
@property (nonatomic ,weak)IBOutlet UILabel *cellExchange;

@end
