//
//  SummerNoticeDetailTableViewCell.h
//  WeCommunity
//
//  Created by madarax on 15/11/4.
//  Copyright © 2015年 Harry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummerNoticeDetailTableViewCell : UITableViewCell

@property (nonatomic ,weak)IBOutlet UIImageView *cellTitleImg;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTitle;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTime;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabTop;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabContent;
@property (nonatomic ,weak)IBOutlet UILabel *cellLabReplay;

@end
